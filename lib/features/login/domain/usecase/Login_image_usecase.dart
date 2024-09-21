import 'package:fpdart/src/either.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/usecase/usecase.dart';
import 'package:online_plants_app/features/login/domain/service_repository/Login_service_repo.dart';

class LoginImageUseCase extends UseCase<List<String>, NoParams> {
  final LoginRepository repo;
  LoginImageUseCase(this.repo);

  @override
  Future<Either<Failure, List<String>>> call(params) {
    return repo.getLoginImages();
  }
}
