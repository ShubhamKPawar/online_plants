// import 'package:equatable/equatable.dart';

abstract class LoginState {
  const LoginState();

  // @override
  // List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoginImageListState extends LoginState {
  final List<String> imagesList;
  const LoginImageListState(this.imagesList);
}

class FailureLoginState extends LoginState {
  final String message;
  FailureLoginState(this.message);
}
