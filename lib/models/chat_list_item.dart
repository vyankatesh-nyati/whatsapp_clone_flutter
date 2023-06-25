import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatListItemModel {
  final String userId;
  final String name;
  final String profileUrl;
  final String timesent;
  final String text;

  ChatListItemModel({
    required this.userId,
    required this.name,
    required this.profileUrl,
    required this.timesent,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'profileUrl': profileUrl,
      'timesent': timesent,
      'text': text,
    };
  }

  factory ChatListItemModel.fromMap(Map<String, dynamic> map) {
    return ChatListItemModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
      timesent: map['timesent'] as String,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatListItemModel.fromJson(String source) =>
      ChatListItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
