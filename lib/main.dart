import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:last_module/Chat_Screen/chat_screen.dart';
import 'Screen_0/login_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> submitted({required String email, required String password, String? username, int? gender, required bool login}) async {
    try {
      if (login) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      } else {
        final authresult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(authresult.user!.uid).set({'username': username, 'gender': gender});
      }
    } catch (err) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatAPP',
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.amber, selectionColor: Color.fromARGB(255, 14, 43, 66)),
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.amber,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.amber),
          appBarTheme: AppBarTheme(
            color: Color.fromARGB(255, 14, 43, 66),
          )),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatScreen();
          } else {
            return LoginScreen(
              submit: submitted,
            );
          }
        },
      ),
    );
  }
}
