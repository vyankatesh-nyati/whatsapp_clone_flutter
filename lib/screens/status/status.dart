import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/status/check_uploaded_file.dart';
import 'package:whatsapp_clone_flutter/screens/status/text_status.dart';
import 'package:whatsapp_clone_flutter/screens/status/widgets/my_status.dart';
import 'package:whatsapp_clone_flutter/screens/status/widgets/others_status.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  void uploadMediaToStatus(BuildContext context) async {
    File? pickedMedia = await pickMediaFromGallery(context);

    if (pickedMedia == null) {
      return;
    }
    if (context.mounted) {
      Navigator.of(context).pushNamed(
        CheckUploadedFileScreen.routeName,
        arguments: pickedMedia,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const MyStatus(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              "Others Status",
              style: TextStyle(
                color: appBarTextColor.withOpacity(0.6),
              ),
            ),
          ),
          const OthersStatus(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(TextStatusScreen.routeName);
              },
              shape: const CircleBorder(),
              backgroundColor: appBarColor,
              child: const Icon(Icons.edit),
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              uploadMediaToStatus(context);
            },
            backgroundColor: tabColor,
            shape: const CircleBorder(),
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 12)
        ],
      ),
    );
  }
}
