import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: tabColor,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: blackColor,
        ),
      ),
    );
  }
}
