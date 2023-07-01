import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/message_reply.dart';

class MessageReplyNotifier extends StateNotifier<MessageReplyModel?> {
  MessageReplyNotifier() : super(null);

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
