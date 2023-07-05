import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/config/server.dart';
import 'package:whatsapp_clone_flutter/models/status.dart';
import 'package:whatsapp_clone_flutter/providers/token_provider.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone_flutter/providers/user_provider.dart';

final statusRepositoryProvider = Provider((ref) => StatusRepository());

class StatusRepository {
  void addNewStatus({
    required BuildContext context,
    required ProviderRef ref,
    required String title,
    required int backgroundColor,
    required double fontSize,
    File? statusFile,
    required String caption,
    required bool isSeen,
    required StatusEnum statusType,
    required String contactList,
  }) async {
    final token = ref.read(tokenProvider);
    final url = Uri.parse("$serverUrl/status/add-status");
    final userDetails = ref.read(userProvider);
    try {
      final request = http.MultipartRequest("POST", url);
      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        "Authorization": token!,
      };
      if (statusFile != null) {
        request.files.add(
          http.MultipartFile(
            'statusFile',
            statusFile.readAsBytes().asStream(),
            statusFile.lengthSync(),
            filename: "${statusType.type}_${userDetails!.id}",
            contentType: MediaType('application', 'x-tar'),
          ),
        );
      }
      request.headers.addAll(headers);
      request.fields.addAll({
        "title": title,
        "backgroundColor": backgroundColor.toString(),
        "fontSize": fontSize.toString(),
        "caption": caption,
        "isSeen": isSeen.toString(),
        'statusType': statusType.type,
        'contactList': contactList,
      });
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      Map<String, dynamic> result = json.decode(response.body);
      if (result["error"] != null) {
        throw result["error"];
      }
      ref
          .read(userProvider.notifier)
          .addNewStatus(StatusModel.fromMap(result["data"]));
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (err) {
      showSnackbar(context: context, content: err.toString());
    }
  }
}
