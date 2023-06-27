// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone_flutter/screens/chat_list/repository/chat_list_repository.dart';

final chatListControllerProvider = Provider((ref) {
  final chatListRepository = ref.watch(chatListRepositoryProvider);
  return ChatListController(ref: ref, chatListRepository: chatListRepository);
});

class ChatListController {
  final ProviderRef ref;
  final ChatListRepository chatListRepository;

  ChatListController({
    required this.ref,
    required this.chatListRepository,
  });

  Future<void> loadChatList(BuildContext context) {
    return chatListRepository.loadInitialChatList(ref, context);
  }
}
