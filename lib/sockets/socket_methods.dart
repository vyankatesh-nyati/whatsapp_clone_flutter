import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';
import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/providers/chat_list_provider.dart';
import 'package:whatsapp_clone_flutter/providers/others_status_list_provider.dart';
import 'package:whatsapp_clone_flutter/sockets/socket.dart';

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

  recievedMessage() {
    _socketClient.on("received-message", (data) {
      final id = ref.read(chatDetailsProvider).id;
      final message = MessageModel.fromMap(data);
      if (id == message.senderId) {
        ref.read(chatDetailsProvider.notifier).addMessage(message);
      }
      ref.read(chatListProvider.notifier).updateChatList(
            ChatListItemModel(
              userId: message.senderId,
              name: data["name"],
              profileUrl: data["profileUrl"],
              text: message.type == MessageEnum.text
                  ? message.text
                  : message.type.message,
              timesent: message.timesent,
              type: message.type,
            ),
          );
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

  seenMessage() {
    _socketClient.on("seen-message", (data) {
      final chatDetails = ref.read(chatDetailsProvider);
      if (chatDetails.id == data["receiverId"]) {
        ref.read(chatDetailsProvider.notifier).seenMessage(data["messageId"]);
      }
    });
  }

  receivedNewStatus() {
    _socketClient.on(
      "added-status",
      (data) {
        // print(data);
        ref.read(othersStatusListProvider.notifier).addNewOthersStatus(
              userId: data["userId"],
              name: data["name"],
              profileUrl: data["profileUrl"],
              statusId: data["_id"],
              title: data["title"],
              backgroundColor: data["backgroundColor"],
              fontSize: data["fontSize"].toDouble(),
              url: data["url"],
              caption: data["caption"],
              isSeen: data["isSeen"],
              statusType: (data["statusType"] as String).toStatusEnum(),
              createdAt: data["createdAt"],
            );
      },
    );
  }
}
