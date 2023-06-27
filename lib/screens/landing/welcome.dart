import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/screens/auth/login.dart';
import 'package:whatsapp_clone_flutter/common/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              const Center(
                child: Text(
                  "Welcome to WhatsApp Clone",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height / 9),
              Image.asset(
                "assets/bg.png",
                color: tabColor,
                height: 340,
                width: 340,
              ),
              SizedBox(height: size.height / 9),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appBarTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: size.width * 0.75,
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                  },
                  buttonText: "AGREE AND CONTINUE",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
