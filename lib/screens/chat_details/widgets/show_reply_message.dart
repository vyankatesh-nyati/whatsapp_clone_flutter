// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';

import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';

class ShowReplyMessage extends ConsumerWidget {
  const ShowReplyMessage({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageModel messageData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatDetails = ref.watch(chatDetailsProvider);

    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 10,
        top: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: chatDetails.id != messageData.senderId
            ? const Color.fromRGBO(1, 30, 31, 0.6)
            : const Color.fromRGBO(22, 28, 31, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chatDetails.id != messageData.messageSenderIdToReply
              ? const Text(
                  'You',
                  style: TextStyle(
                    color: Color.fromRGBO(7, 123, 125, 1),
                    fontSize: 15,
                  ),
                )
              : Text(
                  chatDetails.name,
                  style: TextStyle(
                    color: Colors.deepPurple[200],
                    fontSize: 15,
                  ),
                ),
          const SizedBox(height: 2),
          Text(
            messageData.replyMessageType == MessageEnum.text
                ? messageData.replyText
                : messageData.replyMessageType.message,
          ),
        ],
      ),
    );
  }
}
