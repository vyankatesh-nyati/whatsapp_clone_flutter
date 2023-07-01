import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/models/message_reply.dart';

class MessageReplyNotifier extends StateNotifier<MessageReplyModel?> {
  MessageReplyNotifier()
      : super(
          MessageReplyModel(
            replyText: "replyText",
            userIdToReply: "userIdToReply",
            messageType: MessageEnum.text,
          ),
        );

  void addMessageReply(MessageReplyModel messageReply) {
    state = messageReply;
  }

  void removeMessageReply() {
    state = null;
  }
}

final messageReplyProvider =
    StateNotifierProvider<MessageReplyNotifier, MessageReplyModel?>(
  (ref) => MessageReplyNotifier(),
);
