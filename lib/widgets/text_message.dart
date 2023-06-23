import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    required this.messageData,
  });

  final MessageModel messageData;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          messageData.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
          color: messageData.isMe ? messageColor : senderMessageColor,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 26,
                  top: 8,
                  bottom: 22,
                ),
                child: Text(
                  messageData.textMessage,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 12,
                child: Row(
                  children: [
                    Text(
                      messageData.time,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    if (messageData.isMe) const SizedBox(width: 4),
                    if (messageData.isMe)
                      const Icon(
                        Icons.done_all,
                        size: 16,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
