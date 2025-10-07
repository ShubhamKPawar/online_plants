import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/services_data/domain/service_repository/seller_service_repo.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';
import 'package:online_plants_app/core/usecase/usecase.dart';

class GetSellerUsecase extends UseCase<SellerModel?, String> {
  final SellerServiceRepo repo;
  GetSellerUsecase(this.repo);

  @override
  Future<Either<Failure, SellerModel?>> call(params) {
    return repo.getSellerDetail(params);
  }
}

class AddUpdateSellerUsecase extends UseCase<SellerModel, SellerModel> {
  final SellerServiceRepo repo;
  AddUpdateSellerUsecase(this.repo);

  @override
  Future<Either<Failure, SellerModel>> call(params) {
    return repo.setSellerDetail(params);
  }
}
