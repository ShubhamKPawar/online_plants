class CartModel {
  final int? cartId;
  final int productId;
  final String? productName;
  final String? variety;
  final int? quantity;
  final int? lotSize;
  final String? price;
  final String? userId;
  final String? age;
  final String? height;

  CartModel({
    this.cartId,
    required this.productId,
    this.productName,
    this.variety,
    this.quantity,
    this.lotSize,
    this.price,
    this.userId,
    this.age,
    this.height,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartId: json['cartId'],
      productId: json['productId'],
      productName: json['productName'],
      variety: json['variety'],
      quantity: json['quantity'],
      lotSize: json['lotSize'],
      price: json['price'],
      userId: json['userId'],
      age: json['age'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'productId': productId,
      'productName': productName,
      'variety': variety,
      'quantity': quantity,
      'lotSize': lotSize,
      'price': price,
      'userId': userId,
      'age': age,
      'height': height,
    };
  }
}
