/* eslint-disable camelcase */
/* eslint max-len: ["error", { "code": 160 }]*/

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./Service/serviceAccountKey.json");
admin.initializeApp({credential: admin.credential.cert(serviceAccount), storageBucket: "gs://flutterchat-c5676.appspot.com"});

exports.helloWorld = functions.region("europe-west1").https.onRequest( async (request, response) => {
  await admin.firestore().collection("test").add({success: true});
  response.send("Hello from Firebase!");
});


exports.sendSMSTwilio = functions.region("europe-west1").https.onCall(async (data, context)=>{
  const smsCode = (Math.floor(Math.random() * 9000) + 1000).toString();
  const accountSid = "AC488a4c5e74b1ceee7ebbe9a473aad978";
  const authToken = "14ab54a39b27322d91b8539de2407228";
  const client = require("twilio")(accountSid, authToken);

  await client.messages.create({body: "Verification Code: "+smsCode, from: "+15856327558", to: data.phone_number});
  return {smscode: smsCode};
});

exports.checkUserExists = functions.region("europe-west1").https.onCall(async (data, context) => {
  const username = data.username;
  const email = data.email;
  const docUser = admin.firestore()
      .collection("Users").where("username", "==", username).limit(1).get();


  const docEmail = admin.firestore()
      .collection("Users").where("email_address", "==", email).limit(1).get();

  const promises = await Promise.all([docUser, docEmail]);
  let uError = "F";
  let eError = "F";
  // ERROR HANDLING TO SHOW MULTIPLE ERRORS
  // CHECK IF IT'S NOT EMPTY
  if (!promises[0].empty) {
    uError = "T";
  }
  if (!promises[1].empty) {
    eError = "T";
  }
  if (uError == "T" || eError == "T") {
    throw new functions.https
        .HttpsError("already-exists", uError+" "+eError);
  }
  return {success: true};
});


exports.addUser = functions.region("europe-west1")
    .https.onCall(async (data, context) => {
      const hash = require("crypto-js/sha256");
      const {v4: uuidv4} = require("uuid");
      const username = data.username;
      const email = data.email;
      const encryptedpass = hash(data.password).toString();
      const gender = data.gender;
      const response = await admin.firestore().collection("Users")
          .add({username: username, password: encryptedpass,
            gender: gender,
            email: email});
      const base64data = data.base64data;
      // Without picture
      if (base64data != null) {
        const img_bytes = Buffer.from(base64data, "base64");
        const filename = uuidv4() + ".png";
        const fileReference = admin.storage().bucket().file("users_images/"+response.id+"/"+filename);
        const fileStream = fileReference.createWriteStream({metadata: {contentType: "image/png"}});
        fileStream.end(img_bytes);
        await new Promise((resolve, reject) => {
          fileStream.on("finish", resolve);
          fileStream.on("error", reject);
        });
        await fileReference.makePublic();
        const imgURL = fileReference.publicUrl();
        await admin.firestore().collection("Users").doc(response.id).set({imgURL: imgURL}, {merge: true});
      }
      const customtoken = await admin.auth().createCustomToken(response.id);

      return {success: true, customToken: customtoken};
    });

exports.loginUser = functions.region("europe-west1")
    .https.onCall(async (data, context) => {
      const hash = require("crypto-js/sha256");
      const username = data.username;
      const password = data.password;

      const document = await admin.firestore()
          .collection("Users").where("username", "==", username).limit(1).get();
      if (document.empty) {
        throw new functions.https
            .HttpsError("not-found", "Username doesn't exists.");
      }
      const userDoc = document.docs[0].data();
      const id = document.docs[0].id;
      const encryptedpass = hash(password).toString();
      if (userDoc["password"] != encryptedpass) {
        throw new functions.https.
            HttpsError("invalid-argument",
                "Password incorrect.");
      }
      const customtoken = await admin.auth()
          .createCustomToken(id);
      return {sucess: true, customToken: customtoken};
    },
    );
