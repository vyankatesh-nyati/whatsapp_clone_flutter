import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/screens/details.dart';
import 'package:whatsapp_clone_flutter/screens/login.dart';
import 'package:whatsapp_clone_flutter/widgets/common/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case DetailsScreen.routeName:
      final id = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => DetailsScreen(userId: id),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "Page doest not exists 404"),
        ),
      );
  }
}
