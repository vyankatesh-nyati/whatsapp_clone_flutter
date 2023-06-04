import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/dummy_data/data.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';
import 'package:whatsapp_clone_flutter/widgets/chat_list_item.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: info.length,
          itemBuilder: (context, index) => ChatListItem(
            itemData: ChatListItemModel(
              name: info[index]['name']!,
              message: info[index]['message']!,
              time: info[index]['time']!,
              profilePic: info[index]['profilePic']!,
            ),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: tabColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.chat,
        ),
      ),
    );
  }
}
