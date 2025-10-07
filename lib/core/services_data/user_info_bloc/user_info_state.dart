import 'package:online_plants_app/core/services_data/model/user_model.dart';

abstract class UserInfoState {}

final class UserInitial extends UserInfoState {}

final class UserLoading extends UserInfoState {}

final class GetUserInfoSuccess extends UserInfoState {
  UserModel? model;
  GetUserInfoSuccess(this.model);
}

final class AddUpdateUserInfoSuccess extends UserInfoState {
  UserModel model;
  AddUpdateUserInfoSuccess(this.model);
}

final class UserFailure extends UserInfoState {
  String message;
  UserFailure(this.message);
}

final class ChangePasswordState extends UserInfoState {
  bool status;
  ChangePasswordState(this.status);
}

class LoadingState extends UserInfoState {}

class LoginLoadingState extends UserInfoState {}

class LoginImageListState extends UserInfoState {
  final List<String> imagesList;
  LoginImageListState(this.imagesList);
}

class LoginUserState extends UserInfoState {
  final dynamic userCredential;
  LoginUserState(this.userCredential);
}

class RegisterUserState extends UserInfoState {
  final dynamic userCredential;
  RegisterUserState(this.userCredential);
}

class GoogleLoginState extends UserInfoState {
  final dynamic userCredential;
  GoogleLoginState(this.userCredential);
}

class AppleLoginState extends UserInfoState {
  final dynamic userCredential;
  AppleLoginState(this.userCredential);
}

class LoginFailureState extends UserInfoState {
  final String message;
  LoginFailureState(this.message);
}

class FailureLoginState extends UserInfoState {
  final String message;
  FailureLoginState(this.message);
}

class LoggedInSuccess extends UserInfoState {
  LoggedInSuccess();
}

class LoggedOutSuccess extends UserInfoState {
  LoggedOutSuccess();
}
