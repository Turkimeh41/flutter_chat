import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:last_module/Handler/firebase_handler.dart';
import 'package:last_module/MAIN_MENU/main_menu.dart';

class LoginHandler {
  late final void Function(void Function()) setState;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool loading = false;
  late AnimationController offsetController;
  late AnimationController fadeController;
  late Animation<Offset> offsetAnimation;
  late Animation<double> fadeAnimation;
  late BuildContext context;
  String? userError;
  String? passError;
  void initControllers(thisState) {
    offsetController = AnimationController(vsync: thisState, duration: const Duration(seconds: 1));
    offsetAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(parent: offsetController, curve: Curves.bounceInOut));
    fadeController = AnimationController(vsync: thisState, duration: const Duration(milliseconds: 2000));
    offsetController.forward();
    fadeController.forward();
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: fadeController, curve: Curves.linear));
  }

  bool validateUser() {
    if (userController.text.isEmpty) {
      userError = 'Please fill in the Username Field';
      return false;
    }
    return true;
  }

  validatePassword() {
    if (passController.text.isEmpty) {
      passError = 'Please fill in the Password Field';
      return false;
    }
    return true;
  }

  Future<void> login() async {
    late bool valid;
    setState(() {
      valid = validateUser() & validatePassword();
    });

    if (!valid) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      final customToken = await FirebaseHandler.loginUser(userController.text, passController.text);
      await FirebaseHandler.signInWithCustomToken(customToken);
      setState(() {
        loading = false;
      });
      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) {
        Get.off(() => const MainMenu());
      }
    } on FirebaseFunctionsException catch (error) {
      if (error.code == 'not-found') {
        setState(() {
          userError = error.message;
          loading = false;
        });
      } else if (error.code == 'invalid-argument') {
        setState(() {
          passError = error.message;
          loading = false;
        });
      }
    }
  }
}
