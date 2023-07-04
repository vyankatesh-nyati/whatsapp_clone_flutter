import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone_flutter/config/colors.dart';
import 'package:whatsapp_clone_flutter/models/others_status.dart';

class OthersStatus extends StatelessWidget {
  const OthersStatus({
    super.key,
    required this.othersStatusList,
  });
  final List<OthersStatusModel> othersStatusList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: othersStatusList.length,
        itemBuilder: (context, index) {
          String time = DateFormat.jm().format(
            DateTime.parse(othersStatusList[index]
                .statusList[othersStatusList[index].statusList.length - 1]
                .createdAt),
          );
          String day = DateFormat.EEEE().format(
            DateTime.parse(othersStatusList[index]
                .statusList[othersStatusList[index].statusList.length - 1]
                .createdAt),
          );
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: DottedBorder(
                borderType: BorderType.Circle,
                color: tabColor,
                dashPattern: [
                  125.6 / othersStatusList[index].statusList.length,
                  3
                ],
                strokeWidth: 2,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    othersStatusList[index].profileUrl,
                  ),
                ),
              ),
              title: Text(
                othersStatusList[index].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: appBarTextColor,
                ),
              ),
              subtitle: Text("$day, $time"),
            ),
          );
        },
      ),
    );
  }
}
