import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:whatsapp_clone_flutter/models/chat_details.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/providers/chat_list_provider.dart';
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';

final chatDetailsRepositoryProvider =
    Provider((ref) => ChatDetailsRepository());

class ChatDetailsRepository {
  Future<void> loadChatDetails({
    required String id,
    required BuildContext context,
    required ProviderRef ref,
  }) async {
    final url = Uri.parse('$serverUrl/chat-details/$id');
    final token = ref.read(tokenProvider);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!,
        },
      );
      Map<String, dynamic> result = json.decode(response.body);
      if (result["error"] != null) {
        throw result["error"];
      }
      if (result["data"] != null) {
        ref
            .read(chatDetailsProvider.notifier)
            .updateChatDetails(ChatDetailsModel.fromMap(result["data"]));
      }
    } catch (err) {
      showSnackbar(context: context, content: err.toString());
    }
  }

  void sendTextMessage({
    required ProviderRef ref,
    required String timesent,
    required String text,
    required MessageEnum type,
    required BuildContext context,
  }) async {
    final url = Uri.parse('$serverUrl/send-text-message');
    final token = ref.read(tokenProvider);
    final chatDetails = ref.read(chatDetailsProvider);
    final userDetails = ref.read(userProvider);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!,
        },
        body: json.encode({
          "senderId": userDetails!.id,
          "receiverId": chatDetails.id,
          "timesent": timesent,
          "isSeen": false,
          "text": text,
          "type": type.type,
        }),
      );
      Map<String, dynamic> result = json.decode(response.body);
      if (result["error"] != null) {
        throw result["error"];
      }
      final recieverDetails = ref.read(chatDetailsProvider);
      ref.read(chatListProvider.notifier).updateChatList(
            ChatListItemModel(
              userId: recieverDetails.id,
              name: recieverDetails.name,
              profileUrl: recieverDetails.profileUrl,
              text: text,
              timesent: timesent,
              type: type,
            ),
          );

      ref
          .read(chatDetailsProvider.notifier)
          .addMessage(MessageModel.fromMap(result));
    } catch (err) {
      showSnackbar(context: context, content: err.toString());
    }
  }
}
