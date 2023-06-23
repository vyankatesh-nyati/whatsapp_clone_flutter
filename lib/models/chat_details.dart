// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:whatsapp_clone_flutter/models/message.dart';

class ChatDetailsModel {
  final String id;
  final String name;
  final String profileUrl;
  final bool isOnline;
  final List<MessageModel> chatList;

  ChatDetailsModel({
    required this.id,
    required this.name,
    required this.profileUrl,
    required this.isOnline,
    required this.chatList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profileUrl': profileUrl,
      'isOnline': isOnline,
      'chatList': chatList.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatDetailsModel.fromMap(Map<String, dynamic> map) {
    return ChatDetailsModel(
      id: map['id'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
      isOnline: map['isOnline'] as bool,
      chatList: List<MessageModel>.from(
        (map['chatList'] as List<dynamic>).map<MessageModel>(
          (x) => MessageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatDetailsModel.fromJson(String source) =>
      ChatDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
