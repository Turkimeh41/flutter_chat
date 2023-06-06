// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:last_module/MAIN_MENU/main_menu.dart';
import 'package:last_module/Provider/chat_provider.dart';
import 'package:last_module/Provider/users_provider.dart';
import 'AUTH_SCREEN/LOGIN_SCREEN/login_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Users(),
        ),
        Provider(
          create: (context) => Chats(),
        )
      ],
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TextIT',
          theme: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.amber, selectionColor: Color.fromARGB(255, 14, 43, 66)),
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.amber,
            ),
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Consumer<Chats>(
                  builder: (context, chats, child) {
                    chats.initializeChats();
                    return Consumer<Users>(builder: (context, insUsers, child) {
                      return const MainMenu();
                    });
                  },
                );
              } else {
                return const LoginScreen();
              }
            },
          ),
        );
      },
    );
  }
}
