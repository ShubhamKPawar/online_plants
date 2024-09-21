import 'package:fpdart/src/either.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';
import 'package:online_plants_app/features/login/data/datasource/Login_datasource.dart';
import 'package:online_plants_app/features/login/domain/service_repository/Login_service_repo.dart';

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
}
