class UserModel {
  final String id;
  final String phoneNumber;
  final String name;
  final String profileUrl;

  UserModel({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.profileUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'profileUrl': profileUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      phoneNumber: map['phoneNumber'] as String,
      name: map['name'] as String,
      profileUrl: map['profileUrl'] as String,
    );
  }
}
