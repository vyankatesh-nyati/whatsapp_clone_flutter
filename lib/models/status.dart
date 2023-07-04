import 'package:whatsapp_clone_flutter/common/enums/status_enum.dart';

class StatusModel {
  final String id;
  final String title;
  final int backgroundColor;
  final double fontSize;
  final String url;
  final String caption;
  final bool isSeen;
  final StatusEnum statusType;
  final String createdAt;

  StatusModel({
    required this.id,
    required this.title,
    required this.backgroundColor,
    required this.fontSize,
    required this.url,
    required this.caption,
    required this.isSeen,
    required this.statusType,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'backgroundColor': backgroundColor,
      'fontSize': fontSize,
      'url': url,
      'caption': caption,
      'isSeen': isSeen,
      'statusType': statusType.type,
      'createdAt': createdAt,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      id: map['_id'] as String,
      title: map['title'] as String,
      backgroundColor: map['backgroundColor'] as int,
      fontSize: map['fontSize'] as double,
      url: map['url'] as String,
      caption: map['caption'] as String,
      isSeen: map['isSeen'] as bool,
      statusType: (map['statusType'] as String).toStatusEnum(),
      createdAt: map['createdAt'] as String,
    );
  }
}
