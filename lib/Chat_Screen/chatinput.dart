import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final devH = MediaQuery.of(context).size.height;
    final devW = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: devH * 0.06,
            width: devW * 0.80,
            child: TextField(
              controller: messageController,
              onChanged: (value) {
                setState(() {});
              },
              style: GoogleFonts.aBeeZee(color: Colors.white),
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                fillColor: Color.fromARGB(255, 73, 78, 122),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: messageController.text.trim().isEmpty
                ? null
                : () {
                    FirebaseFirestore.instance.collection('/chat').add({'text': messageController.text, 'sendAt': Timestamp.now(), 'uid': FirebaseAuth.instance.currentUser!.uid});
                    setState(() {
                      messageController.text = '';
                      FocusScope.of(context).unfocus();
                    });
                  },
            icon: const Icon(Icons.send_rounded),
            iconSize: 50,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
