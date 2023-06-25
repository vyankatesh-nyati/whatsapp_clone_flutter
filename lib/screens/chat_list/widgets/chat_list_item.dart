import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({
    super.key,
    required this.itemData,
  });

  final ChatListItemModel itemData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(itemData.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(itemData.profileUrl),
      ),
      subtitle: Text(itemData.text),
      trailing: Text(itemData.timesent),
    );
  }
}
