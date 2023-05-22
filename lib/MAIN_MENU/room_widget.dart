import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:last_module/CHAT_SCREEN/chat_screen.dart';

class RoomWidget extends StatelessWidget {
  const RoomWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.height;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color.fromARGB(255, 28, 41, 65), boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 18, offset: Offset(0, 0))]),
      width: dw,
      height: 70,
      child: InkWell(
        onTap: () => Get.to(() => ChatScreen(index: index)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            alignment: Alignment.center,
            children: [Positioned(left: 10, child: Text('Chat room ${index + 1}', style: GoogleFonts.actor(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))],
          ),
        ),
      ),
    );
  }
}
