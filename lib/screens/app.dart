import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';
import 'package:whatsapp_clone_flutter/screens/calls.dart';
import 'package:whatsapp_clone_flutter/screens/chat_list/chat.dart';
import 'package:whatsapp_clone_flutter/screens/status.dart';
import 'package:whatsapp_clone_flutter/utils/socket_methods.dart';

class AppScreen extends ConsumerWidget {
  static const routeName = "/app-screen";
  const AppScreen({super.key});

  void logout(WidgetRef ref) {
    ref.read(tokenProvider.notifier).removeToken();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? userId;
    Widget bodyContent = const Center(
      child: CircularProgressIndicator(),
    );
    if (ref.watch(userProvider) != null) {
      userId = ref.watch(userProvider)!.id;
      ref.read(socketsProvider).createRoom(userId);
      bodyContent = const TabBarView(
        children: [
          ChatScreen(),
          StatusScreen(),
          CallsScreen(),
        ],
      );
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "WhatsApp Clone",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: appBarTextColor,
            ),
            IconButton(
              onPressed: () {
                logout(ref);
              },
              icon: const Icon(Icons.more_vert),
              color: Colors.grey.shade400,
            )
          ],
          centerTitle: false,
          backgroundColor: appBarColor,
          bottom: TabBar(
            labelColor: tabColor,
            indicatorColor: tabColor,
            unselectedLabelColor: appBarTextColor,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "STATUS",
              ),
              Tab(
                text: "CALLS",
              ),
            ],
          ),
        ),
        body: bodyContent,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
