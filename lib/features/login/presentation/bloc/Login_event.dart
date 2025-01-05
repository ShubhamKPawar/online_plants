abstract class LoginEvent {
  const LoginEvent();
}

final class LoginImageEvent extends LoginEvent {
  LoginImageEvent();
}

final class UserLoginEvent extends LoginEvent {
  final String email;
  final String password;
  UserLoginEvent({required this.email, required this.password});
}

final class UserRegisterEvent extends LoginEvent {
  final String email;
  final String password;
  final String userName;
  UserRegisterEvent(
      {required this.email, required this.password, required this.userName});
}

final class GoogleSignInEvent extends LoginEvent {
  GoogleSignInEvent();
}

final class AppleSignInEvent extends LoginEvent {
  AppleSignInEvent();
}
