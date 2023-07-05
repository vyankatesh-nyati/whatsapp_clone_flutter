// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';
import 'package:whatsapp_clone_flutter/screens/contacts/controller/contact_controller.dart';

import 'package:whatsapp_clone_flutter/screens/status/repository/status_repository.dart';

final statusControllerProvider = Provider((ref) {
  final statusRepository = ref.watch(statusRepositoryProvider);

  return StatusController(
    statusRepository: statusRepository,
    ref: ref,
  );
});

class StatusController {
  final StatusRepository statusRepository;
  final ProviderRef ref;
  StatusController({
    required this.statusRepository,
    required this.ref,
  });

  void addNewStatus({
    required BuildContext context,
    required String title,
    required int backgroundColor,
    required double fontSize,
    required String caption,
    required bool isSeen,
    required StatusEnum statusType,
    File? statusFile,
  }) {
    ref.read(conatctListProvider).whenData((value) {
      String contactString = "";
      for (Contact contact in value) {
        contactString = "$contactString,${contact.phones[0].normalizedNumber}";
      }
      return statusRepository.addNewStatus(
        context: context,
        ref: ref,
        title: title,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        caption: caption,
        isSeen: isSeen,
        statusType: statusType,
        contactList: contactString,
        statusFile: statusFile,
      );
    });
  }
}
