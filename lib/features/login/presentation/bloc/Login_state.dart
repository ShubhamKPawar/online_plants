// import 'package:equatable/equatable.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {
  const LoginState();

  // @override
  // List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginImageListState extends LoginState {
  final List<String> imagesList;
  const LoginImageListState(this.imagesList);
}

class LoginUserState extends LoginState {
  final UserCredential? userCredential;
  LoginUserState(this.userCredential);
}

class RegisterUserState extends LoginState {
  final UserCredential? userCredential;
  RegisterUserState(this.userCredential);
}

class GoogleLoginState extends LoginState {
  final UserCredential? userCredential;
  GoogleLoginState(this.userCredential);
}

class AppleLoginState extends LoginState {
  final UserCredential? userCredential;
  AppleLoginState(this.userCredential);
}

class LoginFailureState extends LoginState {
  final String message;
  LoginFailureState(this.message);
}

class FailureLoginState extends LoginState {
  final String message;
  FailureLoginState(this.message);
}
