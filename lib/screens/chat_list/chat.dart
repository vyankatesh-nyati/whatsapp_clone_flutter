import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/chat_list_item.dart';
import 'package:whatsapp_clone_flutter/providers/chat_list_provider.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/chat_detail.dart';
import 'package:whatsapp_clone_flutter/screens/chat_list/controller/chat_list_controller.dart';
import 'package:whatsapp_clone_flutter/screens/contacts/contacts.dart';
import 'package:whatsapp_clone_flutter/screens/chat_list/widgets/chat_list_item.dart';
import 'package:whatsapp_clone_flutter/utils/socket_methods.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = "/chat-screen";
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    loadChatList();
    ref.read(socketsProvider).recievedMessage();
    ref.read(socketsProvider).sendMessageWithId();
  }

  void loadChatList() async {
    await ref.read(chatListControllerProvider).loadChatList(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<ChatListItemModel> chatList = ref.watch(chatListProvider);

    Widget bodyContent = const Center(
      child: Text("No chats"),
    );

    if (chatList.isNotEmpty) {
      bodyContent = Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(
                    uid: chatList[index].userId,
                  ),
                ),
              );
            },
            child: ChatListItem(
              itemData: chatList[index],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: bodyContent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ContactScreen.routeName);
        },
        backgroundColor: tabColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.chat,
        ),
      ),
    );
  }
}
