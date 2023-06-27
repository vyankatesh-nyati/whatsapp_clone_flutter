import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:whatsapp_clone_flutter/models/chat_details.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';

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
}
