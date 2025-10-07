import 'package:online_plants_app/core/services_data/model/seller_model.dart';

abstract class SellerInfoState {}

final class SellerInitial extends SellerInfoState {}

final class SellerLoading extends SellerInfoState {}

final class GetSellerInfoSuccess extends SellerInfoState {
  SellerModel? model;
  GetSellerInfoSuccess(this.model);
}

final class AddUpdateSellerInfoSuccess extends SellerInfoState {
  SellerModel model;
  AddUpdateSellerInfoSuccess(this.model);
}

final class SellerFailure extends SellerInfoState {
  String message;
  SellerFailure(this.message);
}
