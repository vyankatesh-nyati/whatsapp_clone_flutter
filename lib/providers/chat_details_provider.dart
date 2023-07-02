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

  void changeStatus(bool isOnline) {
    state = ChatDetailsModel(
      id: state.id,
      name: state.name,
      profileUrl: state.profileUrl,
      isOnline: isOnline,
      chatList: state.chatList,
    );
  }

  void seenMessage(String messageId) {
    final chatList = state.chatList.map((chat) {
      if (chat.id == messageId) {
        return MessageModel(
          id: chat.id,
          senderId: chat.senderId,
          receiverId: chat.receiverId,
          text: chat.text,
          timesent: chat.timesent,
          isSeen: true,
          type: chat.type,
          replyText: chat.replyText,
          messageSenderIdToReply: chat.messageSenderIdToReply,
          replyMessageType: chat.replyMessageType,
        );
      }
      return chat;
    }).toList();

    state = ChatDetailsModel(
      id: state.id,
      name: state.name,
      profileUrl: state.profileUrl,
      isOnline: state.isOnline,
      chatList: chatList,
    );
  }

  bool resetChatDetails() {
    state = ChatDetailsModel(
      id: '',
      name: '',
      profileUrl: '',
      isOnline: false,
      chatList: [],
    );
    return true;
  }
}

final chatDetailsProvider =
    StateNotifierProvider<ChatDetailsNotifier, ChatDetailsModel>(
  (ref) => ChatDetailsNotifier(),
);
