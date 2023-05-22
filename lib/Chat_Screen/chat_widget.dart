import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:last_module/Model/message.dart';
import 'package:last_module/Provider/users_provider.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.message});
  final Message message;
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context).getUserData(message.userID);

    bool thisUser = message.userID == FirebaseAuth.instance.currentUser!.uid;

    return Row(
      mainAxisAlignment: thisUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(left: thisUser ? 8 : 0, top: 15, right: !thisUser ? 8 : 0),
          padding: const EdgeInsets.only(top: 5, left: 5, right: 10, bottom: 10),
          decoration: BoxDecoration(
              color: thisUser ? Colors.purple[600] : const Color.fromARGB(255, 60, 61, 136),
              borderRadius: thisUser
                  ? const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(2), bottomRight: Radius.circular(15))
                  : const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(2))),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(
              children: [
                SizedBox(
                    width: 100,
                    child: Text(
                      user.username,
                      overflow: TextOverflow.ellipsis,
                      textAlign: thisUser ? TextAlign.start : TextAlign.end,
                      style: GoogleFonts.actor(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(width: 100, child: Text(message.message, style: GoogleFonts.actor(color: Colors.white))),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    //CHECK DATES IF LESS THAN -1 ITS BEEN MORE THAN 1 DAY, IF ITS NOT THEN IT'S Either in future on present day
                    (calculateDifference(message.dateAt) <= -1)
                        ? DateFormat('MMM d, h:mm a').format(message.dateAt)
                        : (calculateDifference(message.dateAt) <= -364)
                            ? DateFormat().format(message.dateAt)
                            : DateFormat.jms().format(message.dateAt),
                    style: GoogleFonts.actor(fontWeight: FontWeight.bold, fontSize: 11), textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: 26,
                width: 26,
                imageUrl: user.imgURL,
                placeholder: (context, url) {
                  return Image.asset('assets/images/defaultprofile.jpg');
                },
              ),
            )
          ]),
        ),
      ],
    );
  }
}
