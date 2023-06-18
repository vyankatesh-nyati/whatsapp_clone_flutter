import 'package:flutter_riverpod/flutter_riverpod.dart';

class tokenNotifier extends StateNotifier<String> {
  tokenNotifier() : super("");

  void addToken(String token) {
    state = token;
  }
}

final tokenProvider =
    StateNotifierProvider<tokenNotifier, String>((ref) => tokenNotifier());
