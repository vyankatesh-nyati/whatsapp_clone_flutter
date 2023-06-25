// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/utils/socket.dart';

final socketsProvider = Provider((ref) => SocketMethods(ref: ref));

class SocketMethods {
  final ProviderRef ref;
  SocketMethods({
    required this.ref,
  });

  final _socketClient = SocketClient.instance.socket!;

  createRoom(String id) {
    _socketClient.emit("create-room", {
      'clientId': id,
    });
  }

  sendMessage(MessageModel message) {
    _socketClient.emit("send-message", {
      "senderId": message.senderId,
      "receiverId": message.receiverId,
      "text": message.text,
      "timesent": message.timesent,
      "isSeen": message.isSeen,
    });
  }

  recievedMessage() {
    _socketClient.on("received-message", (data) {
      // print(data);
      final id = ref.read(chatDetailsProvider).id;
      final message = MessageModel.fromMap(data);
      // if (id == message.senderId) {
      ref.read(chatDetailsProvider.notifier).addMessage(message);
      // }
    });
  }
}
