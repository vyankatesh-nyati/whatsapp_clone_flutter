import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/providers/chat_list_provider.dart';
import 'package:whatsapp_clone_flutter/common/sockets/socket.dart';

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

  sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
    required String timesent,
    required bool isSeen,
  }) {
    _socketClient.emit("send-message", {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "timesent": timesent,
      "isSeen": isSeen,
    });
    final recieverDetails = ref.read(chatDetailsProvider);
    ref.read(chatListProvider.notifier).updateChatList(
          ChatListItemModel(
            userId: recieverDetails.id,
            name: recieverDetails.name,
            profileUrl: recieverDetails.profileUrl,
            text: text,
            timesent: timesent,
          ),
        );
  }

  sendMessageWithId() {
    _socketClient.on("send-message-received", (data) {
      final message = MessageModel.fromMap(data);
      ref.read(chatDetailsProvider.notifier).addMessage(message);
    });
  }

  recievedMessage() {
    _socketClient.on("received-message", (data) {
      // print(data);
      final id = ref.read(chatDetailsProvider).id;
      final message = MessageModel.fromMap(data);
      if (id == message.senderId) {
        ref.read(chatDetailsProvider.notifier).addMessage(message);
      }
      ref.read(chatListProvider.notifier).updateChatList(ChatListItemModel(
            userId: message.senderId,
            name: data["name"],
            profileUrl: data["profileUrl"],
            text: message.text,
            timesent: message.timesent,
          ));
    });
  }

  statusChange() {
    _socketClient.on("status-change", (data) {
      final chatDetails = ref.read(chatDetailsProvider);
      if (data["userId"] == chatDetails.id) {
        ref.read(chatDetailsProvider.notifier).changeStatus(data["isOnline"]);
      }
    });
  }
}
