import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/chat_details.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';

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

  void addMessage(MessageModel message) {
    state = ChatDetailsModel(
      id: state.id,
      name: state.name,
      profileUrl: state.profileUrl,
      isOnline: state.isOnline,
      chatList: [...state.chatList, message],
    );
  }
}

final chatDetailsProvider =
    StateNotifierProvider<ChatDetailsNotifier, ChatDetailsModel>(
  (ref) => ChatDetailsNotifier(),
);