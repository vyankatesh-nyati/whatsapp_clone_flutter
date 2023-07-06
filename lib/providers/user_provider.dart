import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/status.dart';
import 'package:whatsapp_clone_flutter/models/user.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void addUser(UserModel user) {
    state = user;
  }

  void addNewStatus(StatusModel newStatus) {
    if (state != null) {
      state = UserModel(
        id: state!.id,
        phoneNumber: state!.phoneNumber,
        name: state!.name,
        profileUrl: state!.profileUrl,
        myStatusList: [...state!.myStatusList, newStatus],
      );
    }
  }

  void seenStatus(String statusId, bool isSeen) {
    if (state == null) {
      return;
    }
    final List<StatusModel> myStatusList = state!.myStatusList.map((element) {
      if (element.id == statusId) {
        return StatusModel(
          id: element.id,
          title: element.title,
          backgroundColor: element.backgroundColor,
          fontSize: element.fontSize,
          url: element.url,
          caption: element.caption,
          isSeen: isSeen,
          statusType: element.statusType,
          createdAt: element.createdAt,
        );
      }
      return element;
    }).toList();
    state = UserModel(
      id: state!.id,
      phoneNumber: state!.phoneNumber,
      name: state!.name,
      profileUrl: state!.profileUrl,
      myStatusList: myStatusList,
    );
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
