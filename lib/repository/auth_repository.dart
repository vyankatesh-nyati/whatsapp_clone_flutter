import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/screens/details.dart';
import 'package:whatsapp_clone_flutter/utils/utils.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository {
  void signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
    String? id;
    final url = Uri.parse('$serverUrl/signup');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "phoneNumber": phoneNumber,
        }),
      );
      Map<String, dynamic> result = json.decode(response.body);
      // print(result);
      if (result["error"] != null) {
        if (result["data"] != null) {
          throw result["data"][0]["msg"];
        } else {
          throw result["error"];
        }
      }

      id = result["id"];

      if (id != null) {
        if (context.mounted) {
          Navigator.of(context).pushNamed(
            DetailsScreen.routeName,
            arguments: phoneNumber,
          );
        }
      } else {
        throw "Something went wrong please try again later...";
      }
    } catch (e) {
      showSnackbar(
        context: context,
        content: e.toString(),
      );
    }
  }
}
