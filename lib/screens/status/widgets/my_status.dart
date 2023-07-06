import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/others_status.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';
import 'package:whatsapp_clone_flutter/screens/status/text_status.dart';
import 'package:whatsapp_clone_flutter/screens/status/view_story.dart';

class MyStatus extends ConsumerWidget {
  const MyStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userProvider);
    return ListTile(
      onTap: () {
        if (userDetails.myStatusList.isEmpty) {
          Navigator.of(context).pushNamed(TextStatusScreen.routeName);
        } else {
          Navigator.of(context).pushNamed(
            ViewStoryScreen.routeName,
            arguments: OthersStatusModel(
              id: userDetails.id,
              userId: "",
              name: "My status",
              profileUrl: userDetails.profileUrl,
              statusList: userDetails.myStatusList,
            ),
          );
        }
      },
      leading: userDetails!.myStatusList.isEmpty
          ? CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(userDetails.profileUrl),
              child: const Stack(
                children: [
                  Positioned(
                    bottom: -6,
                    right: -6,
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            )
          : DottedBorder(
              borderType: BorderType.Circle,
              color: tabColor,
              dashPattern: userDetails.myStatusList.length == 1
                  ? [200]
                  : [125.6 / userDetails.myStatusList.length, 3],
              strokeWidth: 2,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(userDetails.profileUrl),
              ),
            ),
      title: Text(
        "My status",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: appBarTextColor,
        ),
      ),
      trailing: userDetails.myStatusList.isEmpty
          ? const SizedBox()
          : Icon(
              Icons.more_horiz,
              color: appBarTextColor,
            ),
    );
  }
}
