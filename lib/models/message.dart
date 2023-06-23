// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  final String textMessage;
  final bool isMe;
  final String time;

  MessageModel({
    required this.isMe,
    required this.textMessage,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'textMessage': textMessage,
      'isMe': isMe,
      'time': time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      textMessage: map['textMessage'] as String,
      isMe: map['isMe'] as bool,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
