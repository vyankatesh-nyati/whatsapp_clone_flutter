import 'dart:convert';
import 'dart:io';
// import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/screens/details.dart';
import 'package:whatsapp_clone_flutter/utils/utils.dart';

import 'package:http_parser/http_parser.dart';

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
            arguments: id,
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

  Future<String?> addUserDetails(
    BuildContext context,
    String userId,
    File? image,
    String name,
  ) async {
    final url = Uri.parse('$serverUrl/signup/$userId');
    String? token;
    try {
      final request = http.MultipartRequest("PATCH", url);
      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      if (image != null) {
        request.files.add(
          http.MultipartFile(
            'profilePic',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: "$userId.jpeg",
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }
      request.headers.addAll(headers);
      request.fields.addAll({"name": name});
      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      Map<String, dynamic> result = json.decode(response.body);
      // print(result);
      if (result["error"] != null) {
        if (result["data"] != null) {
          throw result["data"][0]["msg"];
        } else {
          throw result["error"];
        }
      }
      token = result["token"];
    } catch (err) {
      showSnackbar(
        context: context,
        content: err.toString(),
      );
    }
    return token;
  }
}
