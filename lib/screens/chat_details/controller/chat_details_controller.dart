// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';

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

  void sendTextMessage({
    required String timesent,
    required String text,
    required MessageEnum type,
    required BuildContext context,
  }) {
    return chatDetailsRepository.sendTextMessage(
      ref: ref,
      timesent: timesent,
      text: text,
      type: type,
      context: context,
    );
  }

  void sendFileMessage({
    required String timesent,
    required File chatImage,
    required MessageEnum type,
    required BuildContext context,
  }) {
    return chatDetailsRepository.sendFileMessage(
      ref: ref,
      timesent: timesent,
      chatImage: chatImage,
      type: type,
      context: context,
    );
  }

  void seenMessage({
    required BuildContext context,
    required String senderId,
    required String receiverId,
    required String messageId,
  }) {
    return chatDetailsRepository.seenMessage(
      context: context,
      ref: ref,
      senderId: senderId,
      receiverId: receiverId,
      messageId: messageId,
    );
  }
}
