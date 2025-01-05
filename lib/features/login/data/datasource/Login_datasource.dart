import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginDatasource {
  Future<List<String>> getLoginImages();
  Future<UserCredential?> loginUsingEmailAndPass(
      {required String email, required String password});
  Future<UserCredential?> registerNewUser(
      {required String email,
      required String password,
      required String userName});
  Future<UserCredential?> signInWithGoogleId();
  Future<UserCredential?> signInWithAppleId();
}
