// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/widgets/audio_player.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/widgets/video_player.dart';

class DisplayMessage extends StatelessWidget {
  const DisplayMessage({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageModel messageData;

  @override
  Widget build(BuildContext context) {
    switch (messageData.type) {
      case MessageEnum.text:
        return Text(
          messageData.text,
          style: const TextStyle(
            fontSize: 16,
          ),
        );
      case MessageEnum.image:
        return CachedNetworkImage(
          imageUrl: messageData.text,
          width: 250,
          fit: BoxFit.cover,
        );
      case MessageEnum.video:
        return VideoPlayer(videoUrl: messageData.text);
      case MessageEnum.audio:
        return AudioPlayer(messageData: messageData);
      default:
        return Text(
          messageData.text,
          style: const TextStyle(
            fontSize: 16,
          ),
        );
    }
  }
}
