import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:whatsapp_clone_flutter/models/chat_details.dart';
import 'package:whatsapp_clone_flutter/providers/chat_details_provider.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/controller/chat_details_controller.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/widgets/bottom_message_sheet.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/widgets/text_message.dart';
import 'package:whatsapp_clone_flutter/utils/socket_methods.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const routeName = "/chat-details";

  const ChatDetailScreen({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(socketsProvider).recievedMessage();
    loadData();
  }

  void loadData() async {
    await ref
        .read(chatDetailsControllerProvider)
        .loadChatDetails(id: widget.uid, context: context);
  }

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
  Widget build(BuildContext context) {
    final ChatDetailsModel chatDetails = ref.watch(chatDetailsProvider);
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
          const BottomMessageSheet(),
        ],
      ),
    );
  }
}
