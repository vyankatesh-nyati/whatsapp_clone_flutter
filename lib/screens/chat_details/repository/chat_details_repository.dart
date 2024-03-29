import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:whatsapp_clone_flutter/models/chat_details.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/providers/chat_list_provider.dart';
import 'package:whatsapp_clone_flutter/providers/message_reply_provider.dart';
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
    final url = Uri.parse('$serverUrl/chat/chat-details/$id');
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
    final url = Uri.parse('$serverUrl/chat/send-text-message');
    final token = ref.read(tokenProvider);
    final chatDetails = ref.read(chatDetailsProvider);
    final userDetails = ref.read(userProvider);
    final replyMessage = ref.read(messageReplyProvider);
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
          'replyText': replyMessage == null ? '' : replyMessage.replyText,
          'messageSenderIdToReply':
              replyMessage == null ? '' : replyMessage.userIdToReply,
          'replyMessageType':
              replyMessage == null ? 'text' : replyMessage.messageType.type,
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
    ref.read(messageReplyProvider.notifier).removeMessageReply();
  }

  void sendFileMessage({
    required ProviderRef ref,
    required String timesent,
    required File chatImage,
    required MessageEnum type,
    required BuildContext context,
  }) async {
    final url = Uri.parse('$serverUrl/chat/send-file-message');
    final token = ref.read(tokenProvider);
    final chatDetails = ref.read(chatDetailsProvider);
    final userDetails = ref.read(userProvider);
    final replyMessage = ref.read(messageReplyProvider);
    try {
      final request = http.MultipartRequest("POST", url);
      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        "Authorization": token!,
      };

      request.files.add(
        http.MultipartFile(
          'chatImage',
          chatImage.readAsBytes().asStream(),
          chatImage.lengthSync(),
          filename: "${type.type}_${userDetails!.id}_${chatDetails.id}",
          contentType: MediaType('application', 'x-tar'),
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll({
        "senderId": userDetails.id,
        "receiverId": chatDetails.id,
        "timesent": timesent,
        "isSeen": false.toString(),
        "type": type.type,
        'replyText': replyMessage == null ? '' : replyMessage.replyText,
        'messageSenderIdToReply':
            replyMessage == null ? '' : replyMessage.userIdToReply,
        'replyMessageType':
            replyMessage == null ? 'text' : replyMessage.messageType.type,
      });
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

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
              text: type.message,
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
    ref.read(messageReplyProvider.notifier).removeMessageReply();
  }

  void seenMessage({
    required BuildContext context,
    required ProviderRef ref,
    required String senderId,
    required String receiverId,
    required String messageId,
  }) async {
    final url = Uri.parse('$serverUrl/chat/seen-message');
    final token = ref.read(tokenProvider);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!,
        },
        body: json.encode({
          "senderId": senderId,
          "receiverId": receiverId,
          "messageId": messageId,
        }),
      );
      Map<String, dynamic> result = json.decode(response.body);
      if (result["error"] != null) {
        throw result["error"];
      }
    } catch (err) {
      showSnackbar(context: context, content: err.toString());
    }
  }
}
