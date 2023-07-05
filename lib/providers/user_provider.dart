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
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
