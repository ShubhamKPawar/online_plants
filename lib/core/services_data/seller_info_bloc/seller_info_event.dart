import 'package:online_plants_app/core/services_data/model/seller_model.dart';

abstract class SellerInfoEvent {}

final class GetSellerInfoEvent extends SellerInfoEvent {
  String id;
  GetSellerInfoEvent(this.id);
}

final class AddUpdateSellerInfoEvent extends SellerInfoEvent {
  SellerModel model;
  AddUpdateSellerInfoEvent(this.model);
}
