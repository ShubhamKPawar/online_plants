import 'package:online_plants_app/features/home/data/model/variety_model.dart';

class Category {
  final int? categoryId;
  final String value;
  final List<Variety>? varieties;

  Category({
    this.categoryId,
    required this.value,
    this.varieties,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var list = json['varieties'] as List;
    List<Variety>? varietiesList =
        list.map((i) => Variety.fromJson(i)).toList();

    return Category(
      categoryId: json['categoryId'],
      value: json['value'],
      varieties: varietiesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'value': value,
      'varieties': varieties?.map((v) => v.toJson()).toList() ?? [],
    };
  }
}

// List<Category> parseCategories(String jsonStr) {
//   final jsonData = json.decode(jsonStr) as Map<String, dynamic>;
//   var list = jsonData['categories'] as List;
//   return list.map((jsonItem) => Category.fromJson(jsonItem)).toList();
// }
