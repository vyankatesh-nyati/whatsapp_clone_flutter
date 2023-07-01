import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/message_reply.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/providers/message_reply_provider.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';

class ReplyPreview extends ConsumerWidget {
  const ReplyPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MessageReplyModel? messageReply = ref.watch(messageReplyProvider);
    String _id = ref.watch(userProvider)!.id;
    String chatName = ref.watch(chatDetailsProvider).name;

    if (messageReply == null) {
      return Container();
    }
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: mobileChatBoxColor,
      ),
      padding: const EdgeInsets.only(
        top: 8,
        left: 10,
        right: 10,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: backgroundColor,
        ),
        // height: 55,
        child: Stack(
          children: [
            Row(
              // mainAxisSize: MainAxisSize.max,
              children: [
                // Container(
                //   width: 6,
                //   decoration: BoxDecoration(
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(15),
                //       bottomLeft: Radius.circular(15),
                //     ),
                //     color: Colors.deepPurple[300],
                //   ),
                // ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      messageReply.userIdToReply == _id ? "You" : chatName,
                      style: TextStyle(
                        color: Colors.deepPurple[200],
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Text(
                        messageReply.messageType == MessageEnum.text
                            ? messageReply.replyText
                            : messageReply.messageType.message,
                        style: TextStyle(
                          color: appBarTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              ],
            ),
            Positioned(
              right: 3,
              top: 3,
              child: GestureDetector(
                onTap: () {
                  ref.read(messageReplyProvider.notifier).removeMessageReply();
                },
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: appBarTextColor.withOpacity(0.8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
