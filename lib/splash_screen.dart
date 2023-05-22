import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ValueNotifier<String> dotNotifier;

  @override
  void initState() {
    dotNotifier = ValueNotifier('.');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(milliseconds: 750), (_) {
        if (dotNotifier.value == '.' || dotNotifier.value == '..') {
          dotNotifier.value = '${dotNotifier.value}.';
        } else {
          dotNotifier.value = '.';
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(255, 16, 39, 80), Color.fromARGB(255, 17, 33, 61), Color.fromARGB(255, 2, 27, 43), Color.fromARGB(255, 13, 26, 34)])),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            ValueListenableBuilder(
                valueListenable: dotNotifier,
                builder: (context, value, child) {
                  return RichText(
                      text:
                          TextSpan(text: 'Loading your data, hold tight', style: GoogleFonts.actor(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), children: [TextSpan(text: value)]));
                })
          ],
        )));
  }
}
