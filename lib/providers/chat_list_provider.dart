import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

class ChatListNotifier extends StateNotifier<List<ChatListItemModel>> {
  ChatListNotifier() : super([]);
}

final chatListProvider =
    StateNotifierProvider<ChatListNotifier, List<ChatListItemModel>>(
  (ref) => ChatListNotifier(),
);
