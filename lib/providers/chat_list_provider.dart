import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

class ChatListNotifier extends StateNotifier<List<ChatListItemModel>> {
  ChatListNotifier() : super([]);

  void loadChatList(List<ChatListItemModel> chatList) {
    state = chatList.map((e) {
      if (e.type == MessageEnum.text) {
        return ChatListItemModel(
          userId: e.userId,
          name: e.name,
          profileUrl: e.profileUrl,
          timesent: e.timesent,
          text: e.text,
          type: e.type,
        );
      }

      return ChatListItemModel(
        userId: e.userId,
        name: e.name,
        profileUrl: e.profileUrl,
        timesent: e.timesent,
        text: e.type.message,
        type: e.type,
      );
    }).toList();
  }

  void updateChatList(ChatListItemModel chatListItem) {
    List<ChatListItemModel> updatedList = state
        .where((element) => element.userId != chatListItem.userId)
        .toList();
    updatedList = [chatListItem, ...updatedList];
    state = updatedList;
  }
}

final chatListProvider =
    StateNotifierProvider<ChatListNotifier, List<ChatListItemModel>>(
  (ref) => ChatListNotifier(),
);
