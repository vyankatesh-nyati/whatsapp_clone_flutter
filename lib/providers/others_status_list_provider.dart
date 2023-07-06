import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';
import 'package:whatsapp_clone_flutter/models/others_status.dart';
import 'package:whatsapp_clone_flutter/models/status.dart';

class OthersStatusListNotifier extends StateNotifier<List<OthersStatusModel>> {
  OthersStatusListNotifier() : super([]);

  void addOthersStatusList(List<OthersStatusModel> othersStatusList) {
    state = othersStatusList;
  }

  void seenStatus(String statusId, bool isSeen, String othersId) {
    final othersStatusList = state.map((element) {
      if (element.userId == othersId) {
        final statusList = element.statusList.map((e) {
          if (e.id == statusId) {
            return StatusModel(
              id: e.id,
              title: e.title,
              backgroundColor: e.backgroundColor,
              fontSize: e.fontSize,
              url: e.url,
              caption: e.caption,
              isSeen: isSeen,
              statusType: e.statusType,
              createdAt: e.createdAt,
            );
          }
          return e;
        }).toList();
        return OthersStatusModel(
          id: element.id,
          userId: element.userId,
          name: element.name,
          profileUrl: element.profileUrl,
          statusList: statusList,
        );
      }
      return element;
    }).toList();
    state = othersStatusList;
  }

  void addNewOthersStatus({
    required String userId,
    required String name,
    required String profileUrl,
    required String statusId,
    required String title,
    required int backgroundColor,
    required double fontSize,
    required String url,
    required String caption,
    required bool isSeen,
    required StatusEnum statusType,
    required String createdAt,
  }) {
    List<OthersStatusModel> othersStatusList = state;
    final othersStatusIndex =
        state.indexWhere((element) => element.userId == userId);
    print(othersStatusIndex);
    if (othersStatusIndex != -1) {
      othersStatusList[othersStatusIndex].statusList.add(
            StatusModel(
              id: statusId,
              title: title,
              backgroundColor: backgroundColor,
              fontSize: fontSize,
              url: url,
              caption: caption,
              isSeen: isSeen,
              statusType: statusType,
              createdAt: createdAt,
            ),
          );
    } else {
      othersStatusList.add(
        OthersStatusModel(
          id: userId,
          userId: userId,
          name: name,
          profileUrl: profileUrl,
          statusList: [
            StatusModel(
              id: statusId,
              title: title,
              backgroundColor: backgroundColor,
              fontSize: fontSize,
              url: url,
              caption: caption,
              isSeen: isSeen,
              statusType: statusType,
              createdAt: createdAt,
            )
          ],
        ),
      );
    }
    state = othersStatusList;
  }
}

final othersStatusListProvider =
    StateNotifierProvider<OthersStatusListNotifier, List<OthersStatusModel>>(
  (ref) => OthersStatusListNotifier(),
);
