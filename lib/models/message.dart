import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';

class MessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final String timesent;
  final bool isSeen;
  final MessageEnum type;
  final String replyText;
  final String messageSenderIdToReply;
  final MessageEnum replyMessageType;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.timesent,
    required this.isSeen,
    required this.type,
    required this.replyText,
    required this.messageSenderIdToReply,
    required this.replyMessageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timesent': timesent,
      'isSeen': isSeen,
      'type': type.type,
      'replyText': replyText,
      'messageSenderIdToReply': messageSenderIdToReply,
      'replyMessageType': replyMessageType.type,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      timesent: map['timesent'] as String,
      isSeen: map['isSeen'] as bool,
      type: (map['type'] as String).toEnum(),
      replyText: map['replyText'] ?? '',
      messageSenderIdToReply: map['messageSenderIdToReply'] ?? '',
      replyMessageType: (map['replyMessageType'] as String).toEnum(),
    );
  }
}
