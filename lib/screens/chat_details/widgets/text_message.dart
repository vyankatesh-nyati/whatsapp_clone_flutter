import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';

class TextMessage extends ConsumerWidget {
  const TextMessage({
    super.key,
    required this.messageData,
  });

  final MessageModel messageData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myId = ref.watch(userProvider)!.id;
    return Align(
      alignment: myId == messageData.senderId
          ? Alignment.centerRight
          : Alignment.centerLeft,
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
          color:
              myId == messageData.senderId ? messageColor : senderMessageColor,
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
                  messageData.text,
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
                      messageData.timesent,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    if (myId == messageData.senderId) const SizedBox(width: 4),
                    if (myId == messageData.senderId)
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color:
                            messageData.isSeen ? Colors.blue[300] : Colors.grey,
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
