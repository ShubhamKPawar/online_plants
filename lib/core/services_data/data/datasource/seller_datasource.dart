import 'package:online_plants_app/core/services_data/model/seller_model.dart';

abstract class SellerDatasource {
  Future<SellerModel?> getSellerDetail(String id);
  Future<SellerModel> setSellerDetail(SellerModel sellerModel);
}
