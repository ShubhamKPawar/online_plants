import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';

abstract class SellerServiceRepo {
  Future<Either<Failure, SellerModel?>> getSellerDetail(String id);
  Future<Either<Failure, SellerModel>> setSellerDetail(SellerModel sellerModel);
}
