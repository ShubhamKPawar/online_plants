import 'package:online_plants_app/core/services_data/model/user_model.dart';

abstract class UserInfoEvent {}

final class GetUserInfoEvent extends UserInfoEvent {
  GetUserInfoEvent();
}

final class AddUpdateUserInfoEvent extends UserInfoEvent {
  UserModel model;
  AddUpdateUserInfoEvent(this.model);
}

final class ChangePasswordEvent extends UserInfoEvent {
  String email;
  String previousPassword;
  String currentPassword;
  ChangePasswordEvent(
      {required this.email,
      required this.previousPassword,
      required this.currentPassword});
}

final class LoginImageEvent extends UserInfoEvent {
  LoginImageEvent();
}

final class UserLoginEvent extends UserInfoEvent {
  final String email;
  final String password;
  UserLoginEvent({required this.email, required this.password});
}

final class UserLoggedOutEvent extends UserInfoEvent {
  final bool isSkip;
  UserLoggedOutEvent({required this.isSkip});
}

final class UserRegisterEvent extends UserInfoEvent {
  final String email;
  final String password;
  final String userName;
  final String mobileNo;
  UserRegisterEvent(
      {required this.email,
      required this.password,
      required this.userName,
      required this.mobileNo});
}

final class GoogleSignInEvent extends UserInfoEvent {
  GoogleSignInEvent();
}

final class AppleSignInEvent extends UserInfoEvent {
  AppleSignInEvent();
}
