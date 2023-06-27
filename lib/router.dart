import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/screens/app.dart';
import 'package:whatsapp_clone_flutter/screens/chat_details/chat_detail.dart';
import 'package:whatsapp_clone_flutter/screens/contacts/contacts.dart';
import 'package:whatsapp_clone_flutter/screens/auth/details.dart';
import 'package:whatsapp_clone_flutter/screens/auth/login.dart';
import 'package:whatsapp_clone_flutter/common/widgets/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case DetailsScreen.routeName:
      final id = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => DetailsScreen(userId: id),
      );
    case AppScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AppScreen(),
      );
    case ContactScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ContactScreen(),
      );
    case ChatDetailScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => ChatDetailScreen(
          uid: arguments["id"]!,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "Page doest not exists 404"),
        ),
      );
  }
}
