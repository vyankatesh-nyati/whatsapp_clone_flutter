import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:whatsapp_clone_flutter/router.dart';
import 'package:whatsapp_clone_flutter/screens/app.dart';
import 'package:whatsapp_clone_flutter/screens/landing/welcome.dart';
import 'package:whatsapp_clone_flutter/common/sockets/socket_methods.dart';
import 'package:whatsapp_clone_flutter/common/widgets/error.dart';
import 'package:whatsapp_clone_flutter/common/widgets/loader.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _loading = false;

  @override
  void initState() {
    restoreToken();
    ref.read(socketsProvider).recievedMessage();
    ref.read(socketsProvider).statusChange();
    super.initState();
  }

  void restoreToken() async {
    setState(() {
      _loading = true;
    });
    await ref.read(authControllerProvider).getUserToken();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      home: _loading
          ? const LoaderScreen(appBarText: "WhatsApp Clone")
          : ref.watch(tokenProvider) == null
              ? const WelcomeScreen()
              : ref.watch(userAuthProvider).when(
                    data: (data) {
                      if (data == null) {
                        return const WelcomeScreen();
                      }
                      return const AppScreen();
                    },
                    error: (error, stackTrace) {
                      return ErrorScreen(
                        error: error.toString(),
                      );
                    },
                    loading: () =>
                        const LoaderScreen(appBarText: "WhatsApp Clone"),
                  ),
    );
  }
}
