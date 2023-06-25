import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

class ChatListNotifier extends StateNotifier<List<ChatListItemModel>> {
  ChatListNotifier() : super([]);

  void loadChatList(List<ChatListItemModel> chatList) {
    state = chatList;
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
