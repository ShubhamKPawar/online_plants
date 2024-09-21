import 'package:fpdart/fpdart.dart';
import 'package:online_plants_app/core/exceptions/failure.dart';

abstract class LoginRepository {
  Future<Either<Failure, List<String>>> getLoginImages();
}
