import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:last_module/CHAT_SCREEN/chat_handler.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key, required this.handler});
  final ChatHandler handler;
  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.handler.chatInputsetState = setState;
    final dh = MediaQuery.of(context).size.height;
    final dw = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 10, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: dh * 0.06,
            width: dw * 0.80,
            child: TextField(
              focusNode: widget.handler.messageFocus,
              controller: widget.handler.messageController,
              onChanged: (_) {
                setState(() {});
              },
              style: GoogleFonts.actor(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Send a message...',
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
            onPressed: widget.handler.messageController.text.trim().isEmpty ? null : () => widget.handler.sendMessage(),
            icon: const Icon(Icons.send_rounded),
            iconSize: 42,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
