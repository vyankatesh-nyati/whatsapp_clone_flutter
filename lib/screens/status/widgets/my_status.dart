import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/status.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';

class MyStatus extends ConsumerWidget {
  const MyStatus({
    super.key,
    required this.myStatusList,
  });

  final List<StatusModel> myStatusList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userProvider);
    return ListTile(
      leading: myStatusList.isEmpty
          ? CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(userDetails!.profileUrl),
            )
          : DottedBorder(
              borderType: BorderType.Circle,
              color: tabColor,
              dashPattern: [125.6 / myStatusList.length, 3],
              strokeWidth: 2,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(userDetails!.profileUrl),
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
      trailing: myStatusList.isEmpty
          ? const SizedBox()
          : Icon(
              Icons.more_horiz,
              color: appBarTextColor,
            ),
    );
  }
}
