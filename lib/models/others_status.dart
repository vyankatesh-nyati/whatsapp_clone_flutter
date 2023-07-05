import 'package:whatsapp_clone_flutter/models/status.dart';

class OthersStatusModel {
  final String id;
  final String userId;
  final String name;
  final String profileUrl;
  final List<StatusModel> statusList;

  OthersStatusModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.profileUrl,
    required this.statusList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'name': name,
      'profileUrl': profileUrl,
      'statusList': statusList.map((x) => x.toMap()).toList(),
    };
  }

  factory OthersStatusModel.fromMap(Map<String, dynamic> map) {
    return OthersStatusModel(
      id: map['_id'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
      statusList: List<StatusModel>.from(
        (map['statusList'] as List<dynamic>).map<StatusModel>(
          (x) => StatusModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
