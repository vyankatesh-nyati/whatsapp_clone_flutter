import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({
    super.key,
    required this.appBarText,
  });

  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp Clone"),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
