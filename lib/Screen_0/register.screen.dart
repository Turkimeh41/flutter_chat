// ignore_for_file: constant_identifier_names
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:last_module/Screen_0/login_screen.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({required this.submit, super.key});
  final Future<void> Function({required String email, required String password, String? username, int? gender, required bool login}) submit;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum Gender { Male, Female }

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  late AnimationController maleController;
  late AnimationController femaleController;
  late Animation<double> maleFadeAnimation;
  late Animation<double> femaleFadeAnimation;
  late AudioPlayer audio;
  final GlobalKey<FormState> key = GlobalKey();
  Gender? gender;
  String? _email;
  String? _username;
  String? _password;
  bool genderError = false;

  @override
  void initState() {
    fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    maleController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    femaleController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: fadeController, curve: Curves.linear));

    maleFadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: maleController, curve: Curves.linear));
    femaleFadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: femaleController, curve: Curves.linear));
    audio = AudioPlayer();
    fadeController.forward();
    maleController.addListener(() {
      setState(() {});
    });
    femaleController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    fadeController.dispose();
    maleController.dispose();
    femaleController.dispose();
    audio.dispose();
    super.dispose();
  }

  static const ColorFilter greyscale = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  Future<void> playsound(String path) async {
    AssetSource? source;
    source = AssetSource(path);
    await audio.play(source, mode: PlayerMode.lowLatency);
    source = null;
  }

  Future<void> submitted() async {
    final isvalid = key.currentState!.validate();
    if (gender == null) {
      setState(() {
        //Error message widget
        genderError = true;
      });
      return;
    }
    if (isvalid) {
      key.currentState!.save();
      await widget.submit(email: _email!, password: _password!, login: false, username: _username, gender: gender!.index);
    }
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
              top: device.height * -0.065,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Image.asset(
                  color: Colors.amber,
                  'assets/images/logo.png',
                  height: 312,
                  width: 312,
                ),
              ),
            ),
            Positioned(
              top: device.height * 0.2,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: Text(
                  'TextIT',
                  style: GoogleFonts.abel(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
                top: device.height * 0.2,
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
                                return 'Please fill in the Username field';
                              } else if (value.startsWith('0') ||
                                  value.startsWith('1') ||
                                  value.startsWith('2') ||
                                  value.startsWith('3') ||
                                  value.startsWith('4') ||
                                  value.startsWith('5') ||
                                  value.startsWith('6') ||
                                  value.startsWith('7') ||
                                  value.startsWith('8') ||
                                  value.startsWith('9')) {
                                return 'Username Cannot start with a number';
                              } else if (value.length <= 8) {
                                return 'Please enter a Username that is longer than 8 Characters';
                              }
                              return null;
                            },
                            style: GoogleFonts.actor(color: Colors.amber),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.supervised_user_circle, color: Colors.grey),
                              filled: true,
                              fillColor: const Color.fromARGB(124, 81, 84, 113),
                              labelText: 'USER NAME',
                              labelStyle: GoogleFonts.acme(fontSize: 20, color: Colors.white),
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
                              } else if (value.startsWith('0') ||
                                  value.startsWith('1') ||
                                  value.startsWith('2') ||
                                  value.startsWith('3') ||
                                  value.startsWith('4') ||
                                  value.startsWith('5') ||
                                  value.startsWith('6') ||
                                  value.startsWith('7') ||
                                  value.startsWith('8') ||
                                  value.startsWith('9')) {
                                return 'Passoword Cannot start with a number';
                              } else if (value.length <= 8) {
                                return 'Please enter a password that is longer than 8 Characters';
                              }
                              return null;
                            },
                            style: GoogleFonts.actor(color: Colors.amber),
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                              filled: true,
                              fillColor: const Color.fromARGB(124, 81, 84, 113),
                              labelText: 'PASSWORD',
                              labelStyle: GoogleFonts.acme(fontSize: 20, color: Colors.white),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                            )),
                        SizedBox(
                          height: device.height * 0.03,
                        ),
                        TextFormField(
                            onSaved: (newValue) {
                              _email = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please fill in the email Adress field';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email adress';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.actor(color: Colors.amber),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email, color: Colors.grey),
                              filled: true,
                              fillColor: const Color.fromARGB(124, 81, 84, 113),
                              labelText: 'EMAIL ADDRESS',
                              labelStyle: GoogleFonts.acme(fontSize: 20, color: Colors.white),
                              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                            )),
                        SizedBox(
                          height: device.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                )),
            //BLACK BOX CONTAINER
            Positioned(
              bottom: device.height * 0.20,
              height: device.height * 0.13,
              width: device.width * 0.65,
              child: Container(
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: const BorderRadius.all(Radius.circular(20))),
              ),
            ),
            //Circle for Male
            Positioned(
                left: device.width * 0.22,
                bottom: device.height * 0.16,
                child: FadeTransition(
                  opacity: maleFadeAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                        gradient: gender == Gender.Male
                            ? LinearGradient(
                                begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.blue[600]!, Colors.blue[800]!, Colors.blue[900]!, const Color.fromARGB(255, 14, 25, 60)])
                            : null),
                    height: device.height * 0.22,
                    width: device.width * 0.22,
                  ),
                )),
            Positioned(
                left: device.width * 0.553,
                bottom: device.height * 0.16,
                child: FadeTransition(
                  opacity: femaleFadeAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle,
                        gradient: gender == Gender.Female
                            ? LinearGradient(
                                begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.blue[600]!, Colors.blue[800]!, Colors.blue[900]!, const Color.fromARGB(255, 14, 25, 60)])
                            : null),
                    height: device.height * 0.22,
                    width: device.width * 0.22,
                  ),
                )),
            Positioned(
              left: device.width * 0.168,
              bottom: device.height * 0.18,
              child: InkWell(
                child: ColorFiltered(
                    colorFilter: gender != Gender.Male ? greyscale : const ColorFilter.mode(Colors.transparent, BlendMode.saturation),
                    child: Lottie.asset('assets/animations/male.json', controller: maleController, height: 128, width: 128)),
                onTap: () {
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
                },
              ),
            ),
            Positioned(
              left: device.width * 0.5,
              bottom: device.height * 0.18,
              child: InkWell(
                child: ColorFiltered(
                    colorFilter: gender != Gender.Female ? greyscale : const ColorFilter.mode(Colors.transparent, BlendMode.saturation),
                    child: Lottie.asset('assets/animations/female.json', controller: femaleController, height: 128, width: 128)),
                onTap: () {
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
                },
              ),
            ),
            Positioned(
                bottom: device.height * 0.11,
                height: device.height * 0.08,
                child: Column(
                  children: [
                    Visibility(
                        visible: genderError,
                        child: Text(
                          'Please choose a gender from above',
                          style: GoogleFonts.aclonica(color: Colors.red, fontSize: 14),
                        )),
                    FadeTransition(
                      opacity: fadeAnimation,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(Size(device.width * 0.8, device.height * 0.01)),
                              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                              backgroundColor: const MaterialStatePropertyAll(
                                Colors.amber,
                              )),
                          onPressed: () async {
                            await playsound('audios/flourish_sound.mp3');
                            await submitted();
                          },
                          child: Text(
                            'REGISTER',
                            style: GoogleFonts.archivoNarrow(fontSize: 24),
                          )),
                    ),
                  ],
                )),
            Positioned(
                bottom: device.height * 0.04,
                child: GestureDetector(
                  onTap: () async {
                    await playsound('audios/transition.mp3');
                    Get.off(() => LoginScreen(submit: widget.submit), transition: Transition.upToDown);
                  },
                  child: Text(
                    'you have existing Account?, Login in now!',
                    style: GoogleFonts.acme(decoration: TextDecoration.underline, color: Colors.white),
                  ),
                ))
          ])),
    );
  }
}
