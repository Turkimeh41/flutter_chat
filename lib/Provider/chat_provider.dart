import 'package:last_module/Provider/chatrooms_provider.dart';

class Chats {
  int get chatroomsLength {
    return chatrooms.length;
  }

  final List<ChatRoom> chatrooms = [];

  void initializeChats() {
    for (int i = 0; i < 6; i++) {
      ChatRoom chatroom = ChatRoom("Chatroom${i + 1}");
      chatroom.initializeStreamData();
      chatrooms.add(chatroom);
    }
  }
}
