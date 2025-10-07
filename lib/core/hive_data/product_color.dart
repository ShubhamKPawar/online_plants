import 'package:hive/hive.dart';
part 'product_color.g.dart';

@HiveType(typeId: 4)
class ProductColor {
  @HiveField(0)
  final String? url;
  @HiveField(1)
  final int? color;
  const ProductColor({this.url, this.color});
  ProductColor copyWith({String? url, int? color}) {
    return ProductColor(url: url ?? this.url, color: color ?? this.color);
  }

  Map<String, Object?> toJson() {
    return {'url': url, 'color': color};
  }

  static ProductColor fromJson(Map<String, Object?> json) {
    return ProductColor(
        url: json['url'] == null ? null : json['url'] as String,
        color: json['color'] == null ? null : json['color'] as int);
  }

  @override
  String toString() {
    return '''ProductColor(
                url:$url,
color:$color
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is ProductColor &&
        other.runtimeType == runtimeType &&
        other.url == url &&
        other.color == color;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, url, color);
  }
}
