import 'dart:async';
import 'dart:developer';

import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:last_module/Model/message.dart';

class ChatRoom with ChangeNotifier {
  ChatRoom(this.collection);

  late StreamSubscription chatRoomStreamSub;

  final String collection;
  final List<Message> _messages = [];
  bool initFetch = true;

  List<Message> get getMessages {
    return [..._messages];
  }

  void initializeStreamData() {
    log(chalk.green.bold('initializing Collection Stream: $collection'));
    chatRoomStreamSub = FirebaseFirestore.instance.collection(collection).snapshots().listen((querySnapshot) {
      if (querySnapshot.size == 0) {
        log('At $collection theres no messages, everything empty!');
        return;
      }
      final querySnapshotList = querySnapshot.docChanges;
      log('the fetched data is of ${querySnapshotList.length} length!');
      for (int i = 0; i < querySnapshotList.length; i++) {
        final docs = querySnapshotList[i].doc;
        final data = docs.data();
        _messages.add(Message(userID: data!['userID'], dateAt: (data['sendAt'] as Timestamp).toDate(), message: data['message']));
      }
      log('messages of length ${querySnapshotList.length} added');
      notifyListeners();
    });
  }
}
