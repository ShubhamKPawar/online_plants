class Product {
  final int? productId;
  final String? plantName;
  final String? price;
  final String? discountPrice;
  final String? variety;
  final String? category;
  final String? image;
  final String? stock;
  final List<String>? age;
  final String? description;
  final List<String>? height;
  final String? spray;
  final bool? availability;

  Product({
    this.productId,
    this.plantName,
    this.price,
    this.discountPrice,
    this.variety,
    this.category,
    this.image,
    this.stock,
    this.age,
    this.description,
    this.height,
    this.spray,
    this.availability,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<String> ageList = List<String>.from(json['age'] ?? []);
    List<String> heightList = List<String>.from(json['height'] ?? []);

    return Product(
      productId: json['productId'],
      plantName: json['plant_name'],
      price: json['price'],
      discountPrice: json['discount_price'],
      variety: json['variety'],
      category: json['category'],
      image: json['image'],
      stock: json['stock'],
      age: ageList,
      description: json['description'],
      height: heightList,
      spray: json['spray'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'plant_name': plantName,
      'price': price,
      'discount_price': discountPrice,
      'variety': variety,
      'category': category,
      'image': image,
      'stock': stock,
      'age': age,
      'description': description,
      'height': height,
      'spray': spray,
      'availability': availability,
    };
  }
}
