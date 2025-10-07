import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/services_data/data/datasource/user_datasource.dart';
import 'package:online_plants_app/core/services_data/domain/service_repository/user_service_repo.dart';
import 'package:online_plants_app/core/services_data/model/user_model.dart';

class UserServiceImpl extends UserServiceRepo {
  UserDatasource datasource;
  UserServiceImpl(this.datasource);

  @override
  Future<Either<Failure, UserModel?>> getUserDetail(
      String id, String email) async {
    try {
      var value = await datasource.getUserDetail(id, email);
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> setUserDetail(UserModel userModel) async {
    try {
      var value = await datasource.setUserDetail(userModel);
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> changeUserPassword(
      String email, String prevPassword, String currentPassword) async {
    try {
      var value = await datasource.changeUserPassword(
          email, prevPassword, currentPassword);
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
