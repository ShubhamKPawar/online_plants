class Address {
  final int? addressId;
  final int userId;
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? zip;

  Address({
    this.addressId,
    required this.userId,
    this.street,
    this.city,
    this.state,
    this.country,
    this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressId: json['addressId'],
      userId: json['userId'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zip: json['zip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressId': addressId,
      'userId': userId,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'zip': zip,
    };
  }
}
