import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({
    super.key,
    required this.userData,
  });

  final ChatListItemModel userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text(
              userData.name,
              style: TextStyle(
                color: appBarTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
            color: appBarTextColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
            color: appBarTextColor,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.grey.shade400,
          )
        ],
        centerTitle: false,
        backgroundColor: appBarColor,
      ),
      body: const Center(
        child: Text("HEllo"),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
