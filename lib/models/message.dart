// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageModel {
  // final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final String timesent;
  final bool isSeen;

  MessageModel({
    // required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timesent,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timesent': timesent,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      // id: map['_id'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      timesent: map['timesent'] as String,
      isSeen: map['isSeen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
