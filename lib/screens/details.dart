import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/controllers/auth_controller.dart';
import 'package:whatsapp_clone_flutter/utils/utils.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  static const routeName = "/details";
  const DetailsScreen({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
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

  void onSubmitData() async {
    String name = nameController.text;
    if (name.isEmpty) {
      showSnackbar(
          context: context, content: "Please enter vlid non empty name");
    } else {
      String? token = await ref
          .read(authControllerProvider)
          .addUserDetails(context, widget.userId, pickedImage, name);

      if (context.mounted) {
        if (token == null) {
          showSnackbar(
              context: context,
              content: "Something went wrong please try again later");
        } else {
          ref
              .read(authControllerProvider)
              .saveTokenToLocalStorage(context, token);
        }
      }
    }
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
                    onPressed: onSubmitData,
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
