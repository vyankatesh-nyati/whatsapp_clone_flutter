import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';

class ReplyPreview extends StatelessWidget {
  const ReplyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: mobileChatBoxColor,
      ),
      padding: const EdgeInsets.only(
        top: 8,
        left: 10,
        right: 10,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          color: backgroundColor,
        ),
        height: 55,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    color: Colors.deepPurple[300],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 3,
              top: 3,
              child: GestureDetector(
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: appBarTextColor.withOpacity(0.8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
