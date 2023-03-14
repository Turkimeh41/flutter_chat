import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({required this.document, super.key});
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  @override
  Widget build(BuildContext context) {
    DateTime sendAt = (document['sendAt'] as Timestamp).toDate();
    bool thisUser = document['uid'] == FirebaseAuth.instance.currentUser!.uid;
    final messageLength = (document['text'] as String).length;
    return Row(
      mainAxisAlignment: thisUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5, top: 15),
          padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
          decoration: BoxDecoration(
              color: thisUser ? Colors.purple[600] : const Color.fromARGB(255, 75, 64, 174),
              borderRadius: thisUser
                  ? const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(2), bottomRight: Radius.circular(15))
                  : const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(2))),
          child: Column(
            children: [
              SizedBox(width: 100, child: Text(document['text'], style: GoogleFonts.acme(color: Colors.white))),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 80,
                child: Text(
                  textAlign: TextAlign.end,
                  calculateDifference(sendAt) <= -1 ? DateFormat().format(sendAt) : DateFormat.jms().format(sendAt),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
