import 'package:whatsapp_clone_flutter/models/status.dart';

class UserModel {
  final String id;
  final String phoneNumber;
  final String name;
  final String profileUrl;
  final List<StatusModel> myStatusList;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.profileUrl,
    required this.myStatusList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'profileUrl': profileUrl,
      'myStatusList': myStatusList.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
      myStatusList: List<StatusModel>.from(
        (map['myStatusList'] as List<dynamic>).map<StatusModel>(
          (x) => StatusModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
