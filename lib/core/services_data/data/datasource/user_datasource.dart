import 'package:online_plants_app/core/services_data/model/user_model.dart';

abstract class UserDatasource {
  Future<UserModel?> getUserDetail(String id, String email);
  Future<UserModel> setUserDetail(UserModel userModel);
  Future<bool> changeUserPassword(
      String email, String prevPassword, String currentPassword);
}
