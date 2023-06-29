import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

class ChatListNotifier extends StateNotifier<List<ChatListItemModel>> {
  ChatListNotifier() : super([]);

  void loadChatList(List<ChatListItemModel> chatList) {
    state = chatList.map((e) {
      switch (e.type) {
        case MessageEnum.text:
          return ChatListItemModel(
            userId: e.userId,
            name: e.name,
            profileUrl: e.profileUrl,
            timesent: e.timesent,
            text: e.text,
            type: e.type,
          );
        case MessageEnum.image:
          return ChatListItemModel(
            userId: e.userId,
            name: e.name,
            profileUrl: e.profileUrl,
            timesent: e.timesent,
            text: '📷 image',
            type: e.type,
          );
        case MessageEnum.video:
          return ChatListItemModel(
            userId: e.userId,
            name: e.name,
            profileUrl: e.profileUrl,
            timesent: e.timesent,
            text: '📸 video',
            type: e.type,
          );
        case MessageEnum.gif:
          return ChatListItemModel(
            userId: e.userId,
            name: e.name,
            profileUrl: e.profileUrl,
            timesent: e.timesent,
            text: '🖼 gif',
            type: e.type,
          );
        case MessageEnum.audio:
          return ChatListItemModel(
            userId: e.userId,
            name: e.name,
            profileUrl: e.profileUrl,
            timesent: e.timesent,
            text: '🎵 audio',
            type: e.type,
          );
      }
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
