// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone_flutter/repository/contact_repository.dart';

final conatctListProvider = FutureProvider((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return contactRepository.getAllContactList();
});

final contactControllerProvider = Provider((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return ContactController(contactRepository: contactRepository, ref: ref);
});

class ContactController {
  final ContactRepository contactRepository;
  final ProviderRef ref;

  ContactController({
    required this.contactRepository,
    required this.ref,
  });

  void chatWithSelectedContact(BuildContext context, Contact contact) {
    return contactRepository.chatWithSelectedContact(context, ref, contact);
  }
}
