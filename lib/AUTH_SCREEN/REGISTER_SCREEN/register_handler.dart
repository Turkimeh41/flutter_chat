// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:last_module/Handler/firebase_handler.dart';

enum Gender { Male, Female }

enum Controller { Forward, Backward }

class RegisterHandler {
  //DATA
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Gender? gender;
  XFile? imageFile;

  //Errors
  String? userError;
  String? passError;
  String? emailError;
  bool genderError = false;

  late BuildContext context;
  late void Function(void Function()) setState;
  late void Function(void Function()) setStateImage;

  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  late AnimationController maleController;
  late AnimationController femaleController;
  late AnimationController imageController;
  late Animation<double> maleFadeAnimation;
  late Animation<double> femaleFadeAnimation;
  late Animation<double> imageFadeAnimation;
  late Animation<ColorFilter> filterAnimation;
  bool loading = false;
  int currentScreen = 0;

  void initControllers(thisState) {
    fadeController = AnimationController(vsync: thisState, duration: const Duration(seconds: 2), reverseDuration: const Duration(milliseconds: 1200));
    maleController = AnimationController(vsync: thisState, duration: const Duration(seconds: 2), reverseDuration: const Duration(milliseconds: 1200));
    femaleController = AnimationController(vsync: thisState, duration: const Duration(seconds: 2), reverseDuration: const Duration(milliseconds: 1200));
    imageController = AnimationController(vsync: thisState, duration: const Duration(milliseconds: 1500));
    imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: imageController, curve: Curves.linear));
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: fadeController, curve: Curves.linear));
    maleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: maleController, curve: Curves.linear));
    femaleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: femaleController, curve: Curves.linear));
    fadeController.forward();

    fadeController.addListener(() {
      setState(() {});
    });
    maleController.addListener(() {
      setState(() {});
    });
    femaleController.addListener(() {
      setState(() {});
    });
    imageController.addListener(() {
      setState(() {});
    });
  }

  bool validateUser() {
    if (userController.text.isEmpty) {
      userError = 'Please fill in the Username field.';
      return false;
    } else if (userController.text.startsWith('0') ||
        userController.text.startsWith('1') ||
        userController.text.startsWith('2') ||
        userController.text.startsWith('3') ||
        userController.text.startsWith('4') ||
        userController.text.startsWith('5') ||
        userController.text.startsWith('6') ||
        userController.text.startsWith('7') ||
        userController.text.startsWith('8') ||
        userController.text.startsWith('9')) {
      userError = 'Username Cannot start with a number.';
      return false;
    } else if (userController.text.length <= 3) {
      userError = 'Please enter a Username that is longer than 2 Characters.';
      return false;
    }
    return true;
  }

  bool validatePass() {
    if (passController.text.isEmpty) {
      passError = 'Please fill in the Password field.';
      return false;
    } else if (passController.text.startsWith('0') ||
        passController.text.startsWith('1') ||
        passController.text.startsWith('2') ||
        passController.text.startsWith('3') ||
        passController.text.startsWith('4') ||
        passController.text.startsWith('5') ||
        passController.text.startsWith('6') ||
        passController.text.startsWith('7') ||
        passController.text.startsWith('8') ||
        passController.text.startsWith('9')) {
      passError = 'Passoword Cannot start with a number.';
      return false;
    } else if (passController.text.length <= 8) {
      passError = 'Please enter a password that is longer than 8 Characters.';
      return false;
    }

    return true;
  }

  bool validateEmail() {
    if (emailController.text.isEmpty) {
      emailError = 'Please fill in the email Adress field.';
      return false;
    } else if (!emailController.text.contains('@')) {
      emailError = 'Please enter a valid email adress.';
      return false;
    }
    return true;
  }

  Future<void> switchState(Controller move) async {
    if (currentScreen == 0 && move == Controller.Forward) {
      fadeController.reverse();
      maleController.reverse();
      femaleController.reverse();
      await Future.delayed(const Duration(milliseconds: 700), () {
        setState(() {
          currentScreen = 1;
          imageController.forward();
        });
      });
    } else if (currentScreen == 1 && move == Controller.Backward) {
      imageController.reverse();

      setState(() {
        fadeController.forward();
        maleController.forward();
        femaleController.forward();
        currentScreen = 0;
      });
    }
  }

  void chooseMale() {
    if (gender != Gender.Male) {
      femaleController.reset();
      gender = Gender.Male;
      genderError = false;
      !maleController.isAnimating
          ? setState(() {
              maleController.forward();
            })
          : null;
    }
  }

  void chooseFemale() {
    if (gender != Gender.Female) {
      maleController.reset();
      gender = Gender.Female;
      genderError = false;
      !femaleController.isAnimating
          ? setState(() {
              femaleController.forward();
            })
          : null;
    }
  }

  Future<void> checkUser() async {
    log('test');
    late bool valid;
    setState(() {
      valid = validateUser() & validatePass() & validateEmail();
    });

    if (!valid) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await FirebaseHandler.checkUserExists(userController.text, emailController.text);
      setState(() {
        loading = false;
        switchState(Controller.Forward);
      });
    } on FirebaseFunctionsException catch (error) {
      String errorMessage = error.message!;
      if (errorMessage.substring(0, 1) == 'T') {
        userError = 'Invalid, username already exists within the system.';
      }
      if (errorMessage.substring(2, 3) == 'T') {
        emailError = 'Invalid, Email address already exists within the system.';
      }
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();

    imageFile = await picker.pickImage(source: source);
    setStateImage(() {});
  }

  Future<void> register() async {
    String? base64Data;
    setStateImage(() {
      loading = true;
    });
    if (imageFile != null) {
      final bytes = await File(imageFile!.path).readAsBytes();
      base64Data = base64Encode(bytes);
    }
    String token = await FirebaseHandler.addUser(userController.text, passController.text, emailController.text, gender!.index, base64Data);

    await FirebaseHandler.signInWithCustomToken(token);
    setStateImage(() {
      loading = false;
    });
  }
}
