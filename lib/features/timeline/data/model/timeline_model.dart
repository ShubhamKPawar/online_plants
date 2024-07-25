class Order {
  final String? userId;
  final int? orderId;
  final List<OrderItem>? products;
  final String? totalPrice;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.userId,
    this.orderId,
    this.products,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderItem> productList = (json['products'] as List)
        .map((item) => OrderItem.fromJson(item))
        .toList();

    return Order(
      userId: json['userId'],
      orderId: json['orderId'],
      products: productList,
      totalPrice: json['totalPrice'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderId': orderId,
      'products': products?.map((item) => item.toJson()).toList() ?? [],
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}

class OrderItem {
  final int? productId;
  final String? productName;
  final int? quantity;
  final int? lotSize;
  final String? price;

  OrderItem({
    this.productId,
    this.productName,
    this.quantity,
    this.lotSize,
    this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      quantity: json['quantity'],
      lotSize: json['lotSize'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'lotSize': lotSize,
      'price': price,
    };
  }
}
