import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactRepositoryProvider = Provider((ref) => ContactRepository());

final class ContactRepository {
  Future<List<Contact>> getAllContactList() async {
    List<Contact> contacts = [];
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
    }
    // print(contacts);
    List<Contact> validContacts = [];
    for (Contact contact in contacts) {
      if (contact.phones.isNotEmpty) validContacts.add(contact);
    }
    return validContacts;
  }
}
