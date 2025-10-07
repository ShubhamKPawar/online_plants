abstract class LoginDatasource {
  Future<List<String>> getLoginImages();
  Future<dynamic> loginUsingEmailAndPass({
    required String email,
    required String password,
  });
  Future<dynamic> registerNewUser(
      {required String email,
      required String password,
      required String userName,
      required String mobileNo});
  Future<dynamic> signInWithGoogleId();
  Future<dynamic> signInWithAppleId();
}
