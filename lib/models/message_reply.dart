import 'package:whatsapp_clone_flutter/common/enums/message_enum.dart';

class MessageReplyModel {
  final String replyText;
  final String userIdToReply;
  final MessageEnum messageType;

  MessageReplyModel({
    required this.replyText,
    required this.userIdToReply,
    required this.messageType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'replyText': replyText,
      'userIdToReply': userIdToReply,
      'messageType': messageType,
    };
  }
}
