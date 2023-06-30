import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/widgets/display_message.dart';

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
                padding: messageData.type == MessageEnum.text
                    ? const EdgeInsets.only(
                        left: 16,
                        right: 26,
                        top: 8,
                        bottom: 22,
                      )
                    : messageData.type == MessageEnum.audio
                        ? const EdgeInsets.only(
                            left: 18,
                            right: 7,
                            top: 7,
                            bottom: 22,
                          )
                        : const EdgeInsets.only(
                            left: 7,
                            right: 7,
                            top: 7,
                            bottom: 22,
                          ),
                child: DisplayMessage(
                  messageData: messageData,
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
