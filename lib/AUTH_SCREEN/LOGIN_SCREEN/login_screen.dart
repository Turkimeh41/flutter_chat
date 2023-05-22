import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:last_module/AUTH_SCREEN/LOGIN_SCREEN/login_handler.dart';
import 'package:last_module/AUTH_SCREEN/REGISTER_SCREEN/register.screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final loginHandler = LoginHandler();
  @override
  void initState() {
    loginHandler.context = context;
    loginHandler.initControllers(this);
    loginHandler.setState = setState;
    super.initState();
  }

  @override
  void dispose() {
    loginHandler.offsetController.dispose();
    loginHandler.fadeController.dispose();
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
              gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
            Color.fromARGB(255, 16, 39, 80),
            Color.fromARGB(255, 17, 33, 61),
            Color.fromARGB(255, 2, 27, 43),
            Color.fromARGB(255, 13, 26, 34),
          ])),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: device.height * 0.03,
              child: SlideTransition(
                  position: loginHandler.offsetAnimation,
                  child: FadeTransition(
                    opacity: loginHandler.fadeAnimation,
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
                opacity: loginHandler.fadeAnimation,
                child: Text(
                  'Chat APP',
                  style: GoogleFonts.actor(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
                bottom: device.height * 0.27,
                width: device.width * 0.8,
                child: FadeTransition(
                  opacity: loginHandler.fadeAnimation,
                  child: Column(
                    children: [
                      SizedBox(
                        height: device.height * 0.1,
                      ),
                      TextFormField(
                          onChanged: (_) {
                            if (loginHandler.userError != null) {
                              setState(() {
                                loginHandler.userError = null;
                              });
                            }
                          },
                          controller: loginHandler.userController,
                          style: GoogleFonts.actor(color: Colors.white),
                          decoration: InputDecoration(
                            errorText: loginHandler.userError,
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
                          onChanged: (_) {
                            if (loginHandler.passError != null) {
                              setState(() {
                                loginHandler.passError = null;
                              });
                            }
                          },
                          controller: loginHandler.passController,
                          style: GoogleFonts.actor(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: loginHandler.passError,
                            prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                            filled: true,
                            fillColor: const Color.fromARGB(124, 81, 84, 113),
                            labelText: 'PASSWORD',
                            labelStyle: GoogleFonts.actor(fontSize: 17.5, color: Colors.white, fontWeight: FontWeight.bold),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(68, 0, 0, 0), width: 2), borderRadius: BorderRadius.all(Radius.circular(15))),
                          )),
                      const SizedBox(height: 50),
                      FadeTransition(
                        opacity: loginHandler.fadeAnimation,
                        child: !loginHandler.loading
                            ? ElevatedButton(
                                style: const ButtonStyle(
                                    fixedSize: MaterialStatePropertyAll(Size(260, 40)),
                                    enableFeedback: false,
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                                    backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 196, 151, 15),
                                    )),
                                onPressed: () async => loginHandler.login(),
                                child: Text(
                                  'LOGIN',
                                  style: GoogleFonts.actor(fontSize: 24, fontWeight: FontWeight.bold),
                                ))
                            : const CircularProgressIndicator(),
                      ),
                    ],
                  ),
                )),
            Positioned(
                bottom: device.height * 0.04,
                child: InkWell(
                  enableFeedback: false,
                  onTap: () => Get.off(() => const RegisterScreen(), transition: Transition.downToUp),
                  child: Text(
                    'Not Registered?, Register now!',
                    style: GoogleFonts.actor(decoration: TextDecoration.underline, color: Colors.white),
                  ),
                ))
          ])),
    );
  }
}
