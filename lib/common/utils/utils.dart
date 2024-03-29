import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackbar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<File?> pickImageFormGallery(BuildContext context) async {
  File? image;

  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackbar(context: context, content: e.toString());
  }

  return image;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackbar(context: context, content: e.toString());
  }
  return video;
}

Future<File?> pickMediaFromGallery(BuildContext context) async {
  File? media;
  try {
    final pickedMedia = await ImagePicker().pickMedia();
    if (pickedMedia != null) {
      media = File(pickedMedia.path);
    }
  } catch (e) {
    showSnackbar(context: context, content: e.toString());
  }
  return media;
}
