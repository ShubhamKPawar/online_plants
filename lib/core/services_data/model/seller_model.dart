import 'package:hive/hive.dart';

part 'seller_model.g.dart';

@HiveType(typeId: 2)
class SellerModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String mobileNo;

  @HiveField(4)
  final bool isActive;

  @HiveField(5)
  final String createdDate;

  @HiveField(6)
  final String updatedDate;

  @HiveField(7)
  final List<AddressModel> address;

  @HiveField(8)
  final String mainNurseryName;

  @HiveField(9)
  final String imageUrl;

  SellerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNo,
    required this.isActive,
    required this.createdDate,
    required this.updatedDate,
    required this.address,
    required this.mainNurseryName,
    required this.imageUrl,
  });

  factory SellerModel.fromJson(Map<String, dynamic> map) {
    return SellerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobileNo: map['mobileNo'] ?? '',
      isActive: map['isActive'] ?? false,
      createdDate: map['createdDate'] ?? '',
      updatedDate: map['updatedDate'] ?? '',
      address: List<AddressModel>.from(
        (map['address'] ?? []).map((x) => AddressModel.fromJson(x)),
      ),
      mainNurseryName: map['mainNurseryName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
      'isActive': isActive,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'address': address.map((x) => x.toJson()).toList(),
      'mainNurseryName': mainNurseryName,
      'imageUrl': imageUrl,
    };
  }
}

@HiveType(typeId: 3)
class AddressModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String nurseryName;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String city;

  @HiveField(4)
  final String district;

  @HiveField(5)
  final String pincode;

  @HiveField(6)
  final String contactNo;

  @HiveField(7)
  final String imageUrl;

  AddressModel({
    required this.id,
    required this.nurseryName,
    required this.address,
    required this.city,
    required this.district,
    required this.pincode,
    required this.contactNo,
    required this.imageUrl,
  });

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      nurseryName: map['nurseryName'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      district: map['district'] ?? '',
      pincode: map['pincode'] ?? '',
      contactNo: map['contactNo'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nurseryName': nurseryName,
      'address': address,
      'city': city,
      'district': district,
      'pincode': pincode,
      'contactNo': contactNo,
      'imageUrl': imageUrl,
    };
  }
}



// {
//     "id": "",
//     "name": "Digu Pankaj",
//     "email": "shubhampawar83478@gmail.com",
//     "mobileNo": "9527280094",
//     "isActive": true,
//     "createdDate": "",
//     "updatedDate": "",
//     "address": [
//       {
//         "id": "1",
//         "nurseryName": "Goreshwar Nursery",
//         "address": "Bhalawani",
//         "city": "Bhalawani",
//         "district": "A Nagar",
//         "pincode": "414105",
//         "contactNo": "9527280094",
//       }
//     ]
//   }