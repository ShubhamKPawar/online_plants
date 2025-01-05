import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, List<String>>> getLoginImages();
  Future<Either<Failure, UserCredential?>> loginUsingEmailAndPass(
      {required String email, required String password});
  Future<Either<Failure, UserCredential?>> registerNewUser(
      {required String email,
      required String password,
      required String userName});
  Future<Either<Failure, UserCredential?>> signInWithGoogleId();
  Future<Either<Failure, UserCredential?>> signInWithAppleId();
}
