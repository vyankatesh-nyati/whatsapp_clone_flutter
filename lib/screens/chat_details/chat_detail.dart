import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:whatsapp_clone_flutter/models/chat_details.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/widgets/text_message.dart';

class ChatDetailScreen extends ConsumerWidget {
  static const routeName = "/chat-details";

  const ChatDetailScreen({
    super.key,
    required this.uid,
  });

  final String uid;

  void addDetails(WidgetRef ref) {
    ref.read(chatDetailsProvider.notifier).updateChatDetails(ChatDetailsModel(
          id: "id",
          name: "name",
          profileUrl: "profileUrl",
          isOnline: true,
          chatList: [],
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChatDetailsModel chatDetails = ref.watch(chatDetailsProvider);
    print(chatDetails.profileUrl);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: CircleAvatar(
                foregroundImage: NetworkImage(
                    '$serverBaseUrl/images/profiles/tumor (1112).jpg'),
                // maxRadius: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatDetails.name,
                  style: const TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  chatDetails.isOnline ? "online" : "offline",
                  style: TextStyle(
                    color: appBarTextColor,
                    fontSize: 15,
                  ),
                )
              ],
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
            onPressed: () {
              addDetails(ref);
            },
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
              itemCount: chatDetails.chatList.length,
              itemBuilder: (context, index) => TextMessage(
                messageData: chatDetails.chatList[index],
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
