import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/controller/chat_details_controller.dart';

class BottomMessageSheet extends ConsumerStatefulWidget {
  const BottomMessageSheet({super.key});

  @override
  ConsumerState<BottomMessageSheet> createState() => _BottomMessageSheetState();
}

class _BottomMessageSheetState extends ConsumerState<BottomMessageSheet> {
  final TextEditingController _messageEdiitingController =
      TextEditingController();

  bool showSendButton = false;

  @override
  void dispose() {
    super.dispose();
    _messageEdiitingController.dispose();
  }

  void sendMessage() {
    if (showSendButton) {
      final String text = _messageEdiitingController.text;
      final timesent = DateFormat.Hm().format(DateTime.now());

      ref.read(chatDetailsControllerProvider).sendTextMessage(
            timesent: timesent,
            text: text,
            type: MessageEnum.text,
            context: context,
          );

      _messageEdiitingController.clear();
      setState(() {
        showSendButton = false;
      });
    }
  }

  void sendImage() async {
    File? pickedFile = await pickImageFormGallery(context);
    if (pickedFile != null) {
      final timesent = DateFormat.Hm().format(DateTime.now());
      if (context.mounted) {
        ref.read(chatDetailsControllerProvider).sendFileMessage(
              timesent: timesent,
              chatImage: pickedFile,
              type: MessageEnum.image,
              context: context,
            );
      }
    }
  }

  void sendVideo() async {
    File? pickedVideo = await pickVideoFromGallery(context);
    if (pickedVideo != null) {
      final timesent = DateFormat.Hm().format(DateTime.now());
      if (context.mounted) {
        ref.read(chatDetailsControllerProvider).sendFileMessage(
              timesent: timesent,
              chatImage: pickedVideo,
              type: MessageEnum.video,
              context: context,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageEdiitingController,
            onChanged: (value) {
              if (value.trim().isEmpty) {
                setState(() {
                  showSendButton = false;
                });
              } else {
                setState(() {
                  showSendButton = true;
                });
              }
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: "Message",
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: Icon(
                Icons.emoji_emotions,
                color: appBarTextColor,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: sendVideo,
                    icon: const Icon(Icons.video_camera_back),
                    color: appBarTextColor,
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.gif,
                    color: appBarTextColor,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: sendImage,
                    icon: const Icon(Icons.camera_alt),
                    color: appBarTextColor,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: tabColor,
          radius: 28,
          child: IconButton(
            onPressed: sendMessage,
            icon: Icon(showSendButton ? Icons.send : Icons.mic),
          ),
        ),
      ],
    );
  }
}
