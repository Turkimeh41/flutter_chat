import 'package:flutter/material.dart';
import 'package:last_module/Handler/firebase_handler.dart';
import 'package:last_module/Provider/chatrooms_provider.dart';

class ChatHandler {
  ChatHandler(this.chatRoom);
  final ChatRoom chatRoom;

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  FocusNode messageFocus = FocusNode();

  late void Function(void Function()) setState;
  late void Function(void Function()) chatInputsetState;
  void sendMessage() async {
    String message = messageController.text;
    chatInputsetState(() {
      messageController.text = '';
    });

    await FirebaseHandler.addMessage(chatRoom.collection, message);
    setState(() {
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 50), curve: Curves.linear);
    });
  }
}
