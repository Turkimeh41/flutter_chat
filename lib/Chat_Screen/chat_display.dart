import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:last_module/Chat_Screen/chat_widget.dart';

class ChatDisplay extends StatefulWidget {
  const ChatDisplay({super.key});

  @override
  State<ChatDisplay> createState() => _ChatDisplayState();
}

class _ChatDisplayState extends State<ChatDisplay> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('sendAt').snapshots(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = streamSnapshot.data!.docs;
        return ListView.builder(
          itemBuilder: (context, index) {
            return ChatWidget(
              document: documents[index],
            ); /* Text(
              documents[index]['text'],
              style: const TextStyle(color: Colors.white),
            ); */
          },
          itemCount: documents.length,
        );
      },
    );
  }
}
