import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/features/auth/screens/login.dart';
import 'package:whatsapp_clone_flutter/widgets/common/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "Page doest not exists 404"),
        ),
      );
  }
}
