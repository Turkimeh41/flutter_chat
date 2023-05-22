import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:last_module/MAIN_MENU/room_widget.dart';
import 'package:last_module/Provider/users_provider.dart';
import 'package:last_module/splash_screen.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    final insUsers = Provider.of<Users>(context);
    return FutureBuilder(
        future: insUsers.setUser(),
        builder: (context, futureSnapshot) {
          insUsers.initUserStream();
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 17, 33, 61),
              appBar: AppBar(
                actions: [
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            child: IconButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                },
                                icon: const Icon(Icons.logout_outlined, color: Colors.black)))
                      ];
                    },
                  )
                ],
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                backgroundColor: const Color.fromARGB(255, 8, 24, 37),
              ),
              body: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color.fromARGB(255, 16, 39, 80), Color.fromARGB(255, 17, 33, 61), Color.fromARGB(255, 2, 27, 43), Color.fromARGB(255, 13, 26, 34)])),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return RoomWidget(index: index);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 25);
                      },
                      itemCount: 6)));
        });
  }
}
