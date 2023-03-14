import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:last_module/Chat_Screen/chat_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatDisplay extends StatefulWidget {
  const ChatDisplay({super.key});

  @override
  State<ChatDisplay> createState() => _ChatDisplayState();
}

ScrollController _controller = ScrollController();

class _ChatDisplayState extends State<ChatDisplay> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('chat').orderBy('sendAt', descending: true).snapshots(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final documents = streamSnapshot.data!.docs;
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                controller: _controller,
                itemBuilder: (context, index) {
                  return ChatWidget(document: documents[index], userDoc: snapshot.data!);
                },
                itemCount: documents.length,
              );
            },
          );
        });
  }
}
