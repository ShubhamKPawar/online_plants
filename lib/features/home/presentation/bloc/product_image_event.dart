import 'package:flutter/material.dart';
import 'package:online_plants_app/core/hive_data/product_color.dart';

abstract class ProductImageEvent {}

final class UpgrageImageBackgroundEvent extends ProductImageEvent {
  ImageProvider<Object> imageProvider;
  String imageUrl;
  UpgrageImageBackgroundEvent(
      {required this.imageProvider, required this.imageUrl});
}

final class UpgrageImageBackgroundListEvent extends ProductImageEvent {
  List<ImageProvider<Object>> imageProviderList;
  List<String> imageUrlList;
  UpgrageImageBackgroundListEvent(
      {required this.imageProviderList, required this.imageUrlList});
}

final class AddProductColorEvent extends ProductImageEvent {
  ProductColor color;
  AddProductColorEvent({required this.color});
}

final class GetListProductColorEvent extends ProductImageEvent {}

final class GetProductColorEvent extends ProductImageEvent {
  String url;
  GetProductColorEvent({required this.url});
}

final class AddMultipleProductColorEvent extends ProductImageEvent {
  List<ProductColor> colors;
  AddMultipleProductColorEvent({required this.colors});
}

final class RemoveAllProductColorEvent extends ProductImageEvent {}

final class RemoveSingleProductColorEvent extends ProductImageEvent {
  String url;
  RemoveSingleProductColorEvent({required this.url});
}
