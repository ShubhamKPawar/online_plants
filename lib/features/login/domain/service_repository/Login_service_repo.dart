import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, List<String>>> getLoginImages();
  Future<Either<Failure, dynamic>> loginUsingEmailAndPass({
    required String email,
    required String password,
  });
  Future<Either<Failure, dynamic>> registerNewUser(
      {required String email,
      required String password,
      required String userName,
      required String mobileNo});
  Future<Either<Failure, dynamic>> signInWithGoogleId();
  Future<Either<Failure, dynamic>> signInWithAppleId();
}
