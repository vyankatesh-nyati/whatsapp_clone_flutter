import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/utils/utils.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = "/details";
  const DetailsScreen({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  File? pickedImage;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void pickImage() async {
    pickedImage = await pickImageFormGallery(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 26),
              Stack(
                children: [
                  pickedImage == null
                      ? const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 64,
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey,
                          ),
                        )
                      : CircleAvatar(
                          radius: 64,
                          foregroundImage: FileImage(pickedImage!),
                        ),
                  Positioned(
                    bottom: 0,
                    right: -5,
                    child: IconButton(
                      onPressed: pickImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 26),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.done),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
