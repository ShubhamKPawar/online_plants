import 'package:online_plants_app/features/home/data/model/product_model.dart';

class Variety {
  final int? varietyId;
  final String? variety;
  final List<Product>? products;

  Variety({
    this.varietyId,
    this.variety,
    this.products,
  });

  factory Variety.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Product>? productsList = list.map((i) => Product.fromJson(i)).toList();

    return Variety(
      varietyId: json['varietyId'],
      variety: json['variety'],
      products: productsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'varietyId': varietyId,
      'variety': variety,
      'products': products?.map((p) => p.toJson()).toList() ?? [],
    };
  }
}
