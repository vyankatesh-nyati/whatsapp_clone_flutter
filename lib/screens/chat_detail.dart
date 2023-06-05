import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/dummy_data/data.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';
import 'package:whatsapp_clone_flutter/models/message.dart';
import 'package:whatsapp_clone_flutter/widgets/text_message.dart';

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) => TextMessage(
                messageData: Message(
                  isMe: messages[index]['isMe'] as bool,
                  textMessage: messages[index]['text'] as String,
                  time: messages[index]['time'] as String,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Message",
                    filled: true,
                    fillColor: mobileChatBoxColor,
                    prefixIcon: Icon(
                      Icons.emoji_emotions,
                      color: appBarTextColor,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.attach_file,
                          color: appBarTextColor,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.currency_rupee_outlined,
                          color: appBarTextColor,
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.camera_alt,
                          color: appBarTextColor,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: tabColor,
                radius: 28,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
