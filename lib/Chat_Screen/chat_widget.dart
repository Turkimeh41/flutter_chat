import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({required this.document, super.key});
  final QueryDocumentSnapshot<Map<String, dynamic>> document;
  @override
  Widget build(BuildContext context) {
    final messageLength = (document['text'] as String).length;
    return Row(
      mainAxisAlignment: document['uid'] == FirebaseAuth.instance.currentUser!.uid ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, top: 15),
          padding: EdgeInsets.only(top: 10, left: 10, right: messageLength.toDouble() + 20, bottom: 10),
          decoration: BoxDecoration(color: Color.fromARGB(255, 64, 116, 174), borderRadius: BorderRadius.circular(14)),
          child: SizedBox(width: 100, child: Text(document['text'], style: GoogleFonts.acme(color: Colors.white))),
        ),
      ],
    );
  }
}
