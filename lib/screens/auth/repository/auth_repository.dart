import 'dart:convert';
import 'dart:io';
// import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/models/user.dart';
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';
import 'package:whatsapp_clone_flutter/screens/auth/details.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';

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

  void saveTokenToLocalStorage(
      BuildContext context, String token, ProviderRef ref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool status = await prefs.setString("token", token);
    ref.read(tokenProvider.notifier).addToken(token);
    if (status == false) {
      if (context.mounted) {
        showSnackbar(context: context, content: "Something went wrong");
      }
    }
  }

  void removeTokenFromLocalStorage(
      BuildContext context, ProviderRef ref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool status = await prefs.remove("token");
    ref.read(tokenProvider.notifier).removeToken();
    if (status == false) {
      if (context.mounted) {
        showSnackbar(context: context, content: "Something went wrong");
      }
    }
  }

  Future<String?> getTokenFromLocalStorage(ProviderRef ref) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    if (token != null) {
      ref.read(tokenProvider.notifier).addToken(token);
    }
    return token;
  }

  Future<UserModel?> getUserData(ProviderRef ref) async {
    final String? token = ref.read(tokenProvider);
    // print("it is working");
    UserModel? user;
    if (token == null) {
      return null;
    } else {
      try {
        final url = Uri.parse('$serverUrl/token-validation');
        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
        );
        Map<String, dynamic> result = json.decode(response.body);
        // print(result);
        if (result["error"] != null) {
          return null;
        }

        if (result["data"] != null) {
          user = UserModel.fromMap(result["data"]);
          ref.read(userProvider.notifier).addUser(user);
        } else {
          return null;
        }
      } catch (e) {
        print(e.toString());
      }
    }
    return user;
  }

  void changeStatus(ProviderRef ref, bool isOnline) async {
    final url = Uri.parse('$serverUrl/change-status');
    final token = ref.read(tokenProvider);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token!,
        },
        body: json.encode({
          "isOnline": isOnline,
        }),
      );
      Map<String, dynamic> result = json.decode(response.body);
      if (result["error"] != null) {
        throw result["error"];
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
