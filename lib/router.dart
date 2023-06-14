import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/screens/details.dart';
import 'package:whatsapp_clone_flutter/screens/login.dart';
import 'package:whatsapp_clone_flutter/widgets/common/error.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case DetailsScreen.routeName:
      final phoneNumber = settings.arguments as String;
      print(phoneNumber);
      return MaterialPageRoute(
        builder: (context) => DetailsScreen(phoneNumber: phoneNumber),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "Page doest not exists 404"),
        ),
      );
  }
}
