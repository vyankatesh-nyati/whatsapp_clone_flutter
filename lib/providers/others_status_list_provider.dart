import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}

final othersStatusListProvider =
    StateNotifierProvider<OthersStatusListNotifier, List<OthersStatusModel>>(
  (ref) => OthersStatusListNotifier(),
);
