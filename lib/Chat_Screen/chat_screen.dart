import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:last_module/CHAT_SCREEN/chat_handler.dart';
import 'package:last_module/CHAT_SCREEN/chat_widget.dart';
import 'package:last_module/CHAT_SCREEN/chatinput.dart';
import 'package:last_module/Provider/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:last_module/Provider/chatrooms_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.index});
  final int index;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatHandler handler;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    handler = ChatHandler(Provider.of<Chats>(context).chatrooms[widget.index]);
    handler.setState = setState;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28,
            )),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color.fromARGB(255, 16, 39, 80), Color.fromARGB(255, 17, 33, 61), Color.fromARGB(255, 2, 27, 43), Color.fromARGB(255, 13, 26, 34)])),
            child: ChangeNotifierProvider.value(
              value: handler.chatRoom,
              builder: (context, child) {
                return Consumer<ChatRoom>(
                  builder: (context, chatroom, child) {
                    final messagesList = chatroom.getMessages;
                    return Column(
                      children: [
                        Expanded(
                            child: messagesList.isEmpty
                                ? Center(
                                    child: Text(
                                      'This chatroom is empty,\n  be the first sender!',
                                      style: GoogleFonts.actor(color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                : Scrollbar(
                                    controller: handler.scrollController,
                                    child: ListView.builder(
                                        controller: handler.scrollController,
                                        itemCount: messagesList.length,
                                        itemBuilder: (context, index) {
                                          return ChatWidget(message: messagesList[index]);
                                        }),
                                  )),
                        ChatInput(handler: handler)
                      ],
                    );
                  },
                );
              },
            )));
  }
}
