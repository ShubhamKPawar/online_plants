import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/core/services_data/domain/service_repository/user_service_repo.dart';
import 'package:online_plants_app/core/services_data/model/user_model.dart';
import 'package:online_plants_app/core/usecase/usecase.dart';

class GetUserUsecase extends UseCase<UserModel?, List<String>> {
  final UserServiceRepo repo;
  GetUserUsecase(this.repo);

  @override
  Future<Either<Failure, UserModel?>> call(params) {
    print('here....');
    return repo.getUserDetail(params[0], params[1]);
  }
}

class AddUpdateUserUsecase extends UseCase<UserModel, UserModel> {
  final UserServiceRepo repo;
  AddUpdateUserUsecase(this.repo);

  @override
  Future<Either<Failure, UserModel>> call(params) {
    return repo.setUserDetail(params);
  }
}

class ChangeUserPasswordUseCase extends UseCase<bool, List<String>> {
  final UserServiceRepo repo;
  ChangeUserPasswordUseCase(this.repo);

  @override
  Future<Either<Failure, bool>> call(params) {
    return repo.changeUserPassword(params[0], params[1], params[2]);
  }
}
