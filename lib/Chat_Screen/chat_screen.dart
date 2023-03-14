import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:last_module/Chat_Screen/chatinput.dart';
import 'chat_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController? textController;
  bool texthandler = false;
  bool loading = false;
  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  String? error() {
    if (textController!.text.isEmpty) {
      return 'Text cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final document = FirebaseFirestore.instance.collection('chat');
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 14, 43, 66), actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (bContext) {
                  return AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(bContext).pop();
                            FirebaseAuth.instance.signOut();
                          },
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(bContext).pop();
                          },
                          child: const Text('No'))
                    ],
                    title: const Text('Logout?'),
                    content: const Text('Are you sure you wanna log out?'),
                  );
                },
              );
            },
            icon: const Icon(Icons.login_outlined))
      ]),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
          Color.fromARGB(255, 16, 39, 80),
          Color.fromARGB(255, 17, 33, 61),
          Color.fromARGB(255, 2, 27, 43),
          Color.fromARGB(255, 13, 26, 34),
        ])),
        child: Column(children: const [Expanded(child: ChatDisplay()), ChatInput()]),
      ),
    );
  }
}
