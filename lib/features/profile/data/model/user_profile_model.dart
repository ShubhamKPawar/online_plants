import 'package:online_plants_app/features/profile/data/model/user_address_model.dart';

class UserProfile {
  final int? userId;
  final String name;
  final String? email;
  final List<Address>? address;
  final String phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserProfile({
    this.userId,
    required this.name,
    this.email,
    this.address,
    required this.phone,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    var address = json['address'] as List;
    List<Address>? addressList =
        address.map((i) => Address.fromJson(i)).toList();
    return UserProfile(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      address: addressList,
      phone: json['phone'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'address': address?.map((v) => v.toJson()).toList() ?? [],
      'phone': phone,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
