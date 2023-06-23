// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone_flutter/screens/chat_details/repository/chat_details_repository.dart';

final chatDetailsControllerProvider = Provider((ref) {
  final chatDetailsRepository = ref.watch(chatDetailsRepositoryProvider);
  return ChatDetailsController(
    chatDetailsRepository: chatDetailsRepository,
    ref: ref,
  );
});

class ChatDetailsController {
  final ChatDetailsRepository chatDetailsRepository;
  final ProviderRef ref;

  ChatDetailsController({
    required this.chatDetailsRepository,
    required this.ref,
  });

  Future<void> loadChatDetails(
      {required String id, required BuildContext context}) {
    return chatDetailsRepository.loadChatDetails(
      id: id,
      context: context,
      ref: ref,
    );
  }
}
