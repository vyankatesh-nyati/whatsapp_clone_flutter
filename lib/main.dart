import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/screens/app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      home: const AppScreen(),
    );
  }
}
