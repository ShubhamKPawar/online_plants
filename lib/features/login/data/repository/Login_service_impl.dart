// ignore: file_names, implementation_imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/src/either.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/features/login/data/datasource/login_datasource.dart';
import 'package:online_plants_app/features/login/domain/service_repository/login_service_repo.dart';

class LoginServiceImpl extends LoginRepository {
  LoginDatasource datasource;
  LoginServiceImpl(this.datasource);

  @override
  Future<Either<Failure, List<String>>> getLoginImages() async {
    try {
      var value = await datasource.getLoginImages();
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> loginUsingEmailAndPass(
      {required String email, required String password}) async {
    try {
      var value = await datasource.loginUsingEmailAndPass(
          email: email, password: password);
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> registerNewUser(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      print('object');
      var value = await datasource.registerNewUser(
          email: email, password: password, userName: userName);
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signInWithGoogleId() async {
    try {
      var value = await datasource.signInWithGoogleId();
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signInWithAppleId() async {
    try {
      var value = await datasource.signInWithAppleId();
      return right(value);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
