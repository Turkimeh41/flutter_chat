import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:last_module/Screen_0/register.screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({required this.submit, super.key});
  final Future<void> Function({required String email, required String password, String? username, int? gender, required bool login}) submit;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late AnimationController offsetController;
  late AnimationController fadeController;
  late Animation<Offset> offsetAnimation;
  late Animation<double> fadeAnimation;
  final audio = AudioPlayer();
  final key = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? textError;
  int? state = 0;
  @override
  void initState() {
    offsetController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    offsetAnimation = Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(parent: offsetController, curve: Curves.bounceInOut));
    fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: fadeController, curve: Curves.linear));
    offsetController.forward();
    fadeController.forward();
    super.initState();
  }

  @override
  void dispose() {
    offsetController.dispose();
    fadeController.dispose();
    audio.dispose();
    super.dispose();
  }

  playsound(String path) {
    audio.play(AssetSource(path), mode: PlayerMode.lowLatency);
  }

  Future<void> submitted() async {
    final isvalid = key.currentState!.validate();
    if (isvalid) {
      setState(() {
        state = 1;
      });
      key.currentState!.save();
      Future.delayed(const Duration(milliseconds: 500), () async {
        await widget.submit(email: _username!, password: _password!, login: true).catchError((error) {
          setState(() {
            textError = error.message;
            state = 0;
          });
        });
      });
    }
  }

  String? error(String? textError, int field) {
    return textError;
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: device.height,
          width: device.width,
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color.fromARGB(255, 25, 29, 53), Color.fromARGB(255, 31, 36, 68), Color.fromARGB(255, 7, 8, 15)])),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: device.height * 0.03,
              child: SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Image.asset(
                      color: Colors.amber,
                      'assets/images/logo.png',
                      height: 312,
                      width: 312,
                    ),
                  )),
            ),
            Positioned(
              top: device.height * 0.31,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Text(
                  'Chat APP',
                  style: GoogleFonts.abel(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
                width: device.width * 0.8,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        SizedBox(
                          height: device.height * 0.1,
                        ),
                        TextFormField(
                            onSaved: (newValue) {
                              _username = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill in the Email Field';
                              }
                              return null;
                            },
                            style: GoogleFonts.acme(color: Colors.amber),
                            decoration: InputDecoration(
                              errorText: error(textError, 0),
                              prefixIcon: const Icon(Icons.supervised_user_circle, color: Colors.grey),
                              filled: true,
                              fillColor: const Color.fromARGB(124, 81, 84, 113),
                              labelText: 'USER NAME',
                              labelStyle: GoogleFonts.acme(fontSize: 18, color: Colors.white),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                            )),
                        SizedBox(
                          height: device.height * 0.03,
                        ),
                        TextFormField(
                            onSaved: (newValue) {
                              _password = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill in the password field';
                              }
                              return null;
                            },
                            style: GoogleFonts.actor(color: Colors.amber),
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: error(textError, 1),
                              prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                              filled: true,
                              fillColor: const Color.fromARGB(124, 81, 84, 113),
                              labelText: 'PASSWORD',
                              labelStyle: GoogleFonts.acme(fontSize: 20, color: Colors.white),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                            )),
                        SizedBox(
                          height: device.height * 0.02,
                        ),
                        GestureDetector(
                          child: Text('Forgot Password?', style: GoogleFonts.lato(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16, decoration: TextDecoration.underline)),
                        )
                      ],
                    ),
                  ),
                )),
            Positioned(
                bottom: device.height * 0.2,
                width: device.width * 0.7,
                height: device.height * 0.06,
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: state == 0
                      ? ElevatedButton(
                          style: const ButtonStyle(
                              enableFeedback: false,
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.amber,
                              )),
                          onPressed: () async {
                            try {
                              await playsound('audios/flourish_sound.mp3');
                              await submitted();
                            } catch (error) {
                              rethrow;
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: GoogleFonts.archivoNarrow(fontSize: 24),
                          ))
                      : CircularProgressIndicator(),
                )),
            Positioned(
                bottom: device.height * 0.04,
                child: InkWell(
                  enableFeedback: false,
                  onTap: () async {
                    playsound('audios/air-zoom_754.wav');
                    Get.off(() => RegisterScreen(submit: widget.submit), transition: Transition.downToUp);
                  },
                  child: Text(
                    'Not Registered?, Register now!',
                    style: GoogleFonts.robotoCondensed(decoration: TextDecoration.underline, color: Colors.white),
                  ),
                ))
          ])),
    );
  }
}
