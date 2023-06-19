import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenNotifier extends StateNotifier<String?> {
  TokenNotifier() : super(null);

  void addToken(String token) {
    state = token;
  }

  void removeToken() {
    state = null;
  }
}

final tokenProvider =
    StateNotifierProvider<TokenNotifier, String?>((ref) => TokenNotifier());
