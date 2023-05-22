import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHandler {
  static final _functions = FirebaseFunctions.instanceFor(region: "europe-west1");

  static Future<void> checkUserExists(String username, String email) async {
    await _functions.httpsCallable("checkUserExists").call({"username": username, "email": email});
  }

  static Future<String> addUser(String username, String password, String email, int gender, String? base64Data) async {
    final response = await _functions.httpsCallable("addUser").call({"username": username, "password": password, "email": email, "gender": gender, "base64data": base64Data});
    final data = response.data;

    return data['customToken'];
  }

  static Future<String> loginUser(String username, String password) async {
    final response = await _functions.httpsCallable('loginUser').call({"username": username, "password": password});
    final data = response.data;
    return data['customToken'];
  }

  static Future<void> signInWithCustomToken(String customToken) async {
    await FirebaseAuth.instance.signInWithCustomToken(customToken);
  }

  static Future<void> addMessage(String chatroom, String message) async {
    await FirebaseFirestore.instance.collection(chatroom).add({"message": message, "userID": FirebaseAuth.instance.currentUser!.uid, "sendAt": Timestamp.now()});
  }
}
