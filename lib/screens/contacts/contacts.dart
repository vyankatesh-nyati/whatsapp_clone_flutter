import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/screens/contacts/controller/contact_controller.dart';
import 'package:whatsapp_clone_flutter/common/widgets/error.dart';

class ContactScreen extends ConsumerWidget {
  static const routeName = "/contact";
  const ContactScreen({super.key});

  void onSelectContact(BuildContext context, Contact contact, WidgetRef ref) {
    ref
        .read(contactControllerProvider)
        .chatWithSelectedContact(context, contact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: ref.watch(conatctListProvider).when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No contacts"),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onSelectContact(context, data[index], ref);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    leading: data[index].photo == null
                        ? const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: MemoryImage(data[index].photo!),
                          ),
                    title: Text(data[index].displayName),
                    subtitle: Text(data[index].phones[0].normalizedNumber),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return ErrorScreen(error: error.toString());
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
