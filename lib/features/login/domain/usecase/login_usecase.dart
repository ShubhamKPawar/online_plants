// ignore: implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/usecase/usecase.dart';
import 'package:online_plants_app/features/login/domain/service_repository/login_service_repo.dart';

class LoginImageUseCase extends UseCase<List<String>, NoParams> {
  final LoginRepository repo;
  LoginImageUseCase(this.repo);

  @override
  Future<Either<Failure, List<String>>> call(params) {
    return repo.getLoginImages();
  }
}

class LoginUseCase extends UseCase<dynamic, List<String>> {
  final LoginRepository repo;
  LoginUseCase(this.repo);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repo.loginUsingEmailAndPass(
      email: params.isNotEmpty ? params[0] : '',
      password: params.length > 1 ? params[1] : '',
    );
  }
}

class RegisterUseCase extends UseCase<dynamic, List<String>> {
  final LoginRepository repo;
  RegisterUseCase(this.repo);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    print("Register: ${params.toString()}");

    return repo.registerNewUser(
      email: params.isNotEmpty ? params[0] : '',
      password: params.length > 1 ? params[1] : '',
      userName: params.length > 2 ? params[2] : '',
      mobileNo: params.length > 3 ? params[3] : '',
    );
  }
}

class GoogleLoginUseCase extends UseCase<dynamic, NoParams> {
  final LoginRepository repo;
  GoogleLoginUseCase(this.repo);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repo.signInWithGoogleId();
  }
}

class AppleLoginUseCase extends UseCase<dynamic, NoParams> {
  final LoginRepository repo;
  AppleLoginUseCase(this.repo);

  @override
  Future<Either<Failure, dynamic>> call(params) {
    return repo.signInWithAppleId();
  }
}
