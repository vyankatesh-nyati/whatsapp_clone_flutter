import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/controllers/auth_controller.dart';
import 'package:whatsapp_clone_flutter/router.dart';
import 'package:whatsapp_clone_flutter/screens/chat.dart';
import 'package:whatsapp_clone_flutter/screens/welcome.dart';
import 'package:whatsapp_clone_flutter/widgets/common/error.dart';
import 'package:whatsapp_clone_flutter/widgets/common/loader.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme().copyWith(
          color: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userAuthProvider).when(
            data: (data) {
              if (data == null) {
                return const WelcomeScreen();
              }
              return const ChatScreen();
            },
            error: (error, stackTrace) {
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const LoaderScreen(appBarText: "WhatsApp Clone"),
          ),
    );
  }
}
