import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/chat_details.dart';

class ChatDetailsNotifier extends StateNotifier<ChatDetailsModel> {
  ChatDetailsNotifier()
      : super(ChatDetailsModel(
          id: '',
          name: '',
          profileUrl: '',
          isOnline: false,
          chatList: [],
        ));

  void updateChatDetails(ChatDetailsModel chatDetail) {
    state = chatDetail;
  }
}

final chatDetailsProvider =
    StateNotifierProvider<ChatDetailsNotifier, ChatDetailsModel>(
  (ref) => ChatDetailsNotifier(),
);
