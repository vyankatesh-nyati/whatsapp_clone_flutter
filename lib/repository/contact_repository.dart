import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:whatsapp_clone_flutter/utils/utils.dart';

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

  void chatWithSelectedContact(
      BuildContext context, ProviderRef ref, Contact contact) async {
        
    final url = Uri.parse('$serverUrl//contact/is-exists');
    final token = ref.watch(tokenProvider);
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": token!,
        },
        body: json.encode({
          "phoneNumber": contact.phones[0].normalizedNumber,
        }),
      );
      Map<String, dynamic> result = json.decode(response.body);

      if (result["error"] != null) {
        throw result["error"];
      }

      if (result["isFound"]) {
        print("okay");
      } else {
        if (context.mounted) {
          showSnackbar(
              context: context, content: "Contact is not on a whatsApp clone");
        }
      }
    } catch (err) {
      showSnackbar(context: context, content: err.toString());
    }
  }
}
