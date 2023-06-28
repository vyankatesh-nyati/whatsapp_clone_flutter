import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';

class ChatListItemModel {
  final String userId;
  final String name;
  final String profileUrl;
  final String timesent;
  final String text;
  final MessageEnum type;

  ChatListItemModel({
    required this.userId,
    required this.name,
    required this.profileUrl,
    required this.timesent,
    required this.text,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'profileUrl': profileUrl,
      'timesent': timesent,
      'text': text,
      'type': type.type,
    };
  }

  factory ChatListItemModel.fromMap(Map<String, dynamic> map) {
    return ChatListItemModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
      timesent: map['timesent'] as String,
      text: map['text'] as String,
      type: (map['type'] as String).toEnum(),
    );
  }
}
