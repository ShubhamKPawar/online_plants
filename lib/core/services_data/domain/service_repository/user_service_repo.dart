import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/services_data/model/user_model.dart';

abstract class UserServiceRepo {
  Future<Either<Failure, UserModel?>> getUserDetail(String id, String email);
  Future<Either<Failure, UserModel>> setUserDetail(UserModel userModel);
  Future<Either<Failure, bool>> changeUserPassword(
      String email, String prevPassword, String currentPassword);
}
