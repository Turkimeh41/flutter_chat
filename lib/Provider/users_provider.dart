import 'dart:async';
import 'dart:developer';

import 'package:chalkdart/chalk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:last_module/Model/user.dart';

class Users {
  Map<String, Map<String, dynamic>> _users = {};
  late StreamSubscription userStream;
  late User thisUser;
  Future<void> setUser() async {
    final docsSnapshot = await FirebaseFirestore.instance.collection('Users').doc(auth.FirebaseAuth.instance.currentUser!.uid).get();
    final id = docsSnapshot.id;
    final data = docsSnapshot.data();
    thisUser = User(id: id, username: data!['username'], imgURL: data['imgURL'], email: data['email'], gender: data['gender']);
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> initUserStream() async {
    userStream = FirebaseFirestore.instance.collection("Users").snapshots().listen((querySnapshot) {
      log(chalk.green.bold('data Arrived!'));
      log(chalk.green.bold('the querySnapshot is of length ${querySnapshot.size}'));
      if (_users.length == querySnapshot.size) {
        log(chalk.red.bold('Data is the same of users length, we will not add or change anything'));
        return;
      }
      final userSnapshotList = querySnapshot.docs;
      log(chalk.green.bold('Loading users data!'));
      final Map<String, Map<String, dynamic>> loadedUsers = {};
      for (int i = 0; i < userSnapshotList.length; i++) {
        final id = userSnapshotList[i].id;
        final data = userSnapshotList[i].data();
        loadedUsers.addAll({id: data});
        log(chalk.green.bold('id: $id ======== Data: $data'));
        log('${loadedUsers.entries.length}');
      }
      _users = loadedUsers;
    });
  }

  User getUserData(String uID) {
    final data = _users[uID];
    final user = User(username: data!['username'], imgURL: data['imgURL'], email: data['email'], gender: data['gender']);

    return user;
  }
}
