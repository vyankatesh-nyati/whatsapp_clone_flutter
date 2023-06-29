import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';

class DisplayMessage extends StatelessWidget {
  const DisplayMessage({
    super.key,
    required this.text,
    required this.type,
  });

  final String text;
  final MessageEnum type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MessageEnum.text:
        return Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        );
      case MessageEnum.image:
        return CachedNetworkImage(
          imageUrl: text,
          width: 250,
          fit: BoxFit.cover,
        );
      // print(text);
      default:
        return Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        );
    }
  }
}
