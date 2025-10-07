import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Run build_runner to generate this file

@HiveType(typeId: 0) // Assign a unique ID for Hive storage
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final bool isAdmin;

  @HiveField(4)
  final List<NurseryDetail> nurseryDetails;

  @HiveField(5)
  final String createdDate;

  @HiveField(6)
  final String updatedDate;

  @HiveField(7)
  final String mobileNumber;

  @HiveField(8)
  final String? password;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.isAdmin,
    required this.nurseryDetails,
    required this.createdDate,
    required this.updatedDate,
    required this.mobileNumber,
    this.password,
  });

  // Convert Firestore DocumentSnapshot to UserModel
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      nurseryDetails: (map['nersery_details'] as List<dynamic>)
          .map((e) => NurseryDetail.fromJson(e))
          .toList(),
      createdDate: map['created_date'] ?? '',
      updatedDate: map['updated_date'] ?? '',
      mobileNumber: map['mobile_number'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // Convert UserModel to Firestore Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'isAdmin': isAdmin,
      'nersery_details': nurseryDetails.map((e) => e.toJson()).toList(),
      'created_date': createdDate,
      'updated_date': updatedDate,
      'mobile_number': mobileNumber,
      'password': password,
    };
  }
}

@HiveType(typeId: 1)
class NurseryDetail {
  @HiveField(0)
  final String id;

  NurseryDetail({required this.id});

  factory NurseryDetail.fromJson(Map<String, dynamic> map) {
    return NurseryDetail(id: map['id'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
