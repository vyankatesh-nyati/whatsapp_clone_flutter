import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
    ref: ref,
  );
});

final userAuthProvider = FutureProvider((ref) {
  final authcontroller = ref.watch(authControllerProvider);
  return authcontroller.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  void signInWithPhoneNumber(BuildContext context, String phoneNumber) {
    return authRepository.signInWithPhoneNumber(context, phoneNumber);
  }

  Future<String?> addUserDetails(
      BuildContext context, String userId, File? image, String name) {
    return authRepository.addUserDetails(context, userId, image, name);
  }

  void saveTokenToLocalStorage(BuildContext context, String token) {
    return authRepository.saveTokenToLocalStorage(context, token);
  }

  Future<String?> getUserData() {
    return authRepository.getUserData(ref);
  }
}
