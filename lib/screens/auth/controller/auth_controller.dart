import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/models/user.dart';
import 'package:whatsapp_clone_flutter/screens/auth/repository/auth_repository.dart';

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
    return authRepository.saveTokenToLocalStorage(context, token, ref);
  }

  void removeTokenFromLocalStorage(BuildContext context) {
    return authRepository.removeTokenFromLocalStorage(context, ref);
  }

  Future<String?> getUserToken() {
    return authRepository.getTokenFromLocalStorage(ref);
  }

  Future<UserModel?> getUserData() {
    return authRepository.getUserData(ref);
  }

  void changeStatus(bool isOnline) {
    authRepository.changeStatus(ref, isOnline);
  }
}
