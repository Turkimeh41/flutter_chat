import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:last_module/AUTH_SCREEN/REGISTER_SCREEN/register_handler.dart';

class ImageInput extends StatefulWidget {
  const ImageInput(this.registerHandler, {super.key});
  final RegisterHandler registerHandler;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  void initState() {
    widget.registerHandler.setStateImage = setState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dw = MediaQuery.of(context).size.width;
    final dh = MediaQuery.of(context).size.height;
    return widget.registerHandler.loading == false
        ? Stack(
            children: [
              Positioned(
                width: dw,
                bottom: 1 / 2 * dh,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.registerHandler.imageFile == null ? 'Choose an Image for your profile' : 'Looks Great!',
                      style: GoogleFonts.actor(color: const Color.fromARGB(255, 196, 151, 15), fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),
                    widget.registerHandler.imageFile == null
                        ? const CircleAvatar(
                            backgroundImage: AssetImage('assets/images/defaultprofile.jpg'),
                            radius: 72,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(widget.registerHandler.imageFile!.path)),
                            radius: 72,
                          )
                  ],
                ),
              ),
              Positioned(
                bottom: dh * 2 / 5,
                left: dw * 0.1,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => widget.registerHandler.pickImage(ImageSource.gallery),
                      style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 30)), backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 196, 151, 15))),
                      child: Text('Gallery', style: GoogleFonts.actor(color: Colors.white, fontSize: 18)),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () => widget.registerHandler.pickImage(ImageSource.camera),
                      style: const ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(150, 30)), backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 196, 151, 15))),
                      child: Text('Camera', style: GoogleFonts.actor(color: Colors.white, fontSize: 18)),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: dh * 0.3,
                left: dw * 0.79,
                child: TextButton(
                    onPressed: () => widget.registerHandler.register(),
                    child: Text(
                      widget.registerHandler.imageFile == null ? 'Skip' : 'Next',
                      style: GoogleFonts.actor(fontSize: 22, color: Colors.amber),
                    )),
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
