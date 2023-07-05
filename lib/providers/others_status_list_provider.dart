import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/others_status.dart';

class OthersStatusListNotifier extends StateNotifier<List<OthersStatusModel>> {
  OthersStatusListNotifier() : super([]);

  addOthersStatusList(List<OthersStatusModel> othersStatusList) {
    state = othersStatusList;
  }
}

final othersStatusListProvider =
    StateNotifierProvider<OthersStatusListNotifier, List<OthersStatusModel>>(
  (ref) => OthersStatusListNotifier(),
);
