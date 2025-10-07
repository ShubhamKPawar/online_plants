import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/services_data/data/datasource/seller_datasource.dart';
import 'package:online_plants_app/core/services_data/domain/service_repository/seller_service_repo.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';

class SellerServiceImpl extends SellerServiceRepo {
  SellerDatasource datasource;
  SellerServiceImpl(this.datasource);

  @override
  Future<Either<Failure, SellerModel?>> getSellerDetail(String id) async {
    try {
      var value = await datasource.getSellerDetail(id);
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SellerModel>> setSellerDetail(
      SellerModel sellerModel) async {
    try {
      var value = await datasource.setSellerDetail(sellerModel);
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
