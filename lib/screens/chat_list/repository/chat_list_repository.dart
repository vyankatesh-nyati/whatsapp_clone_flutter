import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';
import 'package:whatsapp_clone_flutter/providers/chat_list_provider.dart';
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:whatsapp_clone_flutter/utils/utils.dart';

final chatListRepositoryProvider = Provider((ref) => ChatListRepository());

class ChatListRepository {
  Future<void> loadInitialChatList(
    ProviderRef ref,
    BuildContext context,
  ) async {
    final url = Uri.parse('$serverUrl/contact-list');
    final token = ref.read(tokenProvider);

    try {
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': token!,
      });
      Map<String, dynamic> result = json.decode(response.body);
      if (result["error"] != null) {
        throw result["error"];
      }
      // print(result["data"]);
      List<dynamic> resultedList = result["data"] as List<dynamic>;

      if (resultedList.isNotEmpty) {
        List<ChatListItemModel> chatList = resultedList
            .map((element) => ChatListItemModel.fromMap(element))
            .toList();
        ref.read(chatListProvider.notifier).loadChatList(chatList);
      }
    } catch (err) {
      showSnackbar(context: context, content: err.toString());
    }
  }
}
