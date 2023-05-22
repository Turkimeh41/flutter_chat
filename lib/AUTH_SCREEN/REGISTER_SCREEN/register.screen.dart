// ignore_for_file: constant_identifier_names
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:last_module/AUTH_SCREEN/REGISTER_SCREEN/register_handler.dart';
import 'package:last_module/AUTH_SCREEN/REGISTER_SCREEN/image_input.dart';
import 'package:last_module/AUTH_SCREEN/LOGIN_SCREEN/login_screen.dart';
import 'package:last_module/color_filter_modes.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin {
  ColorFilterModes mode = ColorFilterModes();
  RegisterHandler registerHandler = RegisterHandler();

  @override
  void initState() {
    registerHandler.setState = setState;
    registerHandler.initControllers(this);

    super.initState();
  }

  @override
  void dispose() {
    registerHandler.fadeController.dispose();
    registerHandler.maleController.dispose();
    registerHandler.femaleController.dispose();
    registerHandler.imageController.dispose();
    super.dispose();
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
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 16, 39, 80), Color.fromARGB(255, 17, 33, 61), Color.fromARGB(255, 2, 27, 43), Color.fromARGB(255, 13, 26, 34)])),
          child: registerHandler.currentScreen == 0
              ? Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: device.height * -0.065,
                    child: FadeTransition(
                      opacity: registerHandler.fadeAnimation,
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
                      opacity: registerHandler.fadeAnimation,
                      child: Text(
                        'TextIT',
                        style: GoogleFonts.actor(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: device.height * 0.2,
                    width: device.width * 0.8,
                    child: FadeTransition(
                      opacity: registerHandler.fadeAnimation,
                      child: Column(
                        children: [
                          SizedBox(
                            height: device.height * 0.1,
                          ),
                          TextFormField(
                              controller: registerHandler.userController,
                              onChanged: (_) {
                                if (registerHandler.userError != null) {
                                  setState(() {
                                    registerHandler.userError = null;
                                  });
                                }
                              },
                              style: GoogleFonts.actor(color: Colors.white),
                              decoration: InputDecoration(
                                errorText: registerHandler.userError,
                                prefixIcon: const Icon(Icons.supervised_user_circle, color: Colors.grey),
                                filled: true,
                                fillColor: const Color.fromARGB(124, 81, 84, 113),
                                labelText: 'USER NAME',
                                labelStyle: GoogleFonts.actor(fontSize: 17.5, color: Colors.white, fontWeight: FontWeight.bold),
                                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                              )),
                          SizedBox(
                            height: device.height * 0.03,
                          ),
                          TextFormField(
                              controller: registerHandler.passController,
                              onChanged: (_) {
                                if (registerHandler.passError != null) {
                                  setState(() {
                                    registerHandler.passError = null;
                                  });
                                }
                              },
                              style: GoogleFonts.actor(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: registerHandler.passError,
                                prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                                filled: true,
                                fillColor: const Color.fromARGB(124, 81, 84, 113),
                                labelText: 'PASSWORD',
                                labelStyle: GoogleFonts.actor(fontSize: 17.5, color: Colors.white, fontWeight: FontWeight.bold),
                                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                              )),
                          SizedBox(
                            height: device.height * 0.03,
                          ),
                          TextFormField(
                              controller: registerHandler.emailController,
                              onChanged: (_) {
                                if (registerHandler.emailError != null) {
                                  setState(() {
                                    registerHandler.emailError = null;
                                  });
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.actor(color: const Color.fromARGB(255, 248, 248, 248)),
                              decoration: InputDecoration(
                                errorText: registerHandler.emailError,
                                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                                filled: true,
                                fillColor: const Color.fromARGB(124, 81, 84, 113),
                                labelText: 'EMAIL ADDRESS',
                                labelStyle: GoogleFonts.actor(fontSize: 17.5, color: Colors.white, fontWeight: FontWeight.bold),
                                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                              )),
                          SizedBox(
                            height: device.height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //BLACK BOX CONTAINER
                  Positioned(
                    bottom: device.height * 0.155,
                    height: device.height * 0.17,
                    width: device.width * 0.65,
                    child: FadeTransition(
                      opacity: registerHandler.fadeAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                      ),
                    ),
                  ),
                  //MALE GENDER SMALL ICON
                  Positioned(
                      bottom: device.height * 0.284,
                      right: device.width * 0.62,
                      child: FadeTransition(
                        opacity: registerHandler.maleFadeAnimation,
                        child: ColorFiltered(
                            colorFilter: registerHandler.gender != Gender.Male ? mode.greyscale : mode.normal,
                            child: const Icon(
                              size: 32,
                              Icons.male_rounded,
                              color: Colors.blue,
                            )),
                      )),
                  //FEMALE GENDER SMALL ICON
                  Positioned(
                    bottom: device.height * 0.284,
                    right: device.width * 0.295,
                    child: FadeTransition(
                      opacity: registerHandler.femaleFadeAnimation,
                      child: ColorFiltered(
                          colorFilter: registerHandler.gender != Gender.Female ? mode.greyscale : mode.normal,
                          child: const Icon(
                            size: 32,
                            Icons.female_rounded,
                            color: Colors.pink,
                          )),
                    ),
                  ),
                  //Circle for Male background BLUE COLOR
                  Positioned(
                      left: device.width * 0.22,
                      bottom: device.height * 0.11,
                      child: FadeTransition(
                        opacity: registerHandler.maleFadeAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.circle,
                              gradient: registerHandler.gender == Gender.Male
                                  ? LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colors.blue[600]!, const Color.fromARGB(255, 11, 23, 37), Colors.blue[900]!, const Color.fromARGB(255, 14, 25, 60)])
                                  : null),
                          height: device.height * 0.22,
                          width: device.width * 0.22,
                        ),
                      )),
                  //Circle for Female background PINK COLOR
                  Positioned(
                      left: device.width * 0.553,
                      bottom: device.height * 0.11,
                      child: FadeTransition(
                        opacity: registerHandler.femaleFadeAnimation,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.circle,
                              gradient: registerHandler.gender == Gender.Female
                                  ? const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Color.fromARGB(255, 222, 30, 229), Color.fromARGB(255, 95, 21, 192), Color.fromARGB(255, 161, 13, 124), Color.fromARGB(255, 59, 14, 68)])
                                  : null),
                          height: device.height * 0.22,
                          width: device.width * 0.22,
                        ),
                      )),
                  //LOTTIE for MALE
                  Positioned(
                    left: device.width * 0.168,
                    bottom: device.height * 0.133,
                    child: FadeTransition(
                      opacity: registerHandler.fadeAnimation,
                      child: InkWell(
                          child: ColorFiltered(
                              colorFilter: registerHandler.gender != Gender.Male ? mode.greyscale : mode.normal,
                              child: Lottie.asset('assets/animations/male.json', controller: registerHandler.maleController, height: 128, width: 128)),
                          onTap: () => registerHandler.chooseMale()),
                    ),
                  ),

                  //LOTTIE for FEMALE
                  Positioned(
                    left: device.width * 0.5,
                    bottom: device.height * 0.133,
                    child: FadeTransition(
                      opacity: registerHandler.fadeAnimation,
                      child: InkWell(
                        child: ColorFiltered(
                            colorFilter: registerHandler.gender != Gender.Female ? mode.greyscale : mode.normal,
                            child: Lottie.asset('assets/animations/female.json', controller: registerHandler.femaleController, height: 128, width: 128)),
                        onTap: () => registerHandler.chooseFemale(),
                      ),
                    ),
                  ),

                  Positioned(
                      bottom: device.height * 0.07,
                      height: device.height * 0.08,
                      child: Column(
                        children: [
                          Visibility(
                              visible: registerHandler.genderError,
                              child: Text(
                                'Please choose a gender from above',
                                style: GoogleFonts.actor(color: Colors.red, fontSize: 14),
                              )),
                          FadeTransition(
                            opacity: registerHandler.fadeAnimation,
                            child: !registerHandler.loading
                                ? ElevatedButton(
                                    style: ButtonStyle(
                                        fixedSize: MaterialStatePropertyAll(Size(device.width * 0.8, device.height * 0.01)),
                                        shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                        backgroundColor: const MaterialStatePropertyAll(
                                          Color.fromARGB(255, 196, 151, 15),
                                        )),
                                    onPressed: () async => registerHandler.checkUser(),
                                    child: Text(
                                      'REGISTER',
                                      style: GoogleFonts.actor(fontSize: 24, fontWeight: FontWeight.bold),
                                    ))
                                : null,
                          ),
                        ],
                      )),
                  Positioned(
                    bottom: device.height * 0.017,
                    child: registerHandler.loading ? Lottie.asset('assets/animations/linear_loading.json', width: 128, height: 128) : const SizedBox(),
                  ),
                  Positioned(
                    bottom: device.height * 0.04,
                    child: FadeTransition(
                      opacity: registerHandler.fadeAnimation,
                      child: GestureDetector(
                        onTap: () async => Get.off(() => const LoginScreen(), transition: Transition.upToDown),
                        child: Text(
                          'you have existing Account?, Login in now!',
                          style: GoogleFonts.actor(decoration: TextDecoration.underline, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ])
              : FadeTransition(opacity: registerHandler.imageFadeAnimation, child: ImageInput(registerHandler))),
    );
  }
}
