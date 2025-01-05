import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<UserCredential?> userLogin(
    {required String email, required String password}) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential? userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential;
  } on FirebaseException catch (e) {
    throw Exception(e);
  } catch (e) {
    throw Exception(e);
  }
}

Future<UserCredential?> userRegister(
    {required String email,
    required String password,
    required String userName}) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential? userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return userCredential;
  } on FirebaseException catch (e) {
    throw Exception(e);
  } catch (e) {
    throw Exception(e);
  }
}

Future<UserCredential?> userSignInWithGoogle() async {
  try {
    UserCredential credential = await signInWithGoogle();
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      if (kDebugMode) print('email already in use');
      try {
        await GoogleSignIn().signOut();
      } catch (e) {
        if (kDebugMode) print('GOOGLE ERROR> $e');
      }
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
        if (kDebugMode) print("ERROR>>>$e");
      }

      throw Exception("email-already-in-use");
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error Occurred..$e');
    }
    throw Exception(e);
  }
  return null;
}

Future<UserCredential> signInWithGoogle() async {
  try {
    await GoogleSignIn().signOut();
  } catch (e) {
    if (kDebugMode) print("Error sign out $e");
  }

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  if (googleAuth == null) {
    if (kDebugMode) print("Google Auth Failed");
    return throw Exception("Google Auth Failed.");
  }
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  if (kDebugMode) {
    print("credential $credential");
    print("googleAuth.accessToken ${googleAuth.accessToken}");
    print("googleAuth.idToken ${googleAuth.idToken}");
  }

  try {
    UserCredential googleLoginCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return googleLoginCredential;
  } catch (e) {
    if (kDebugMode) {
      print("google sign in error $e");
    }
    throw Exception(e);
  }
}

Future<UserCredential?> userSignInApple() async {
  bool isAvailable = await SignInWithApple.isAvailable();
  if (!isAvailable) {
    throw Exception('Apple login is not available');
  }

  try {
    // Step 1: Get Apple ID Credential
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Step 2: Create OAuthCredential for Firebase
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Step 3: Sign in to Firebase with the OAuthCredential
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    // Step 4: Handle the returned user (optional)
    final firebaseUser = userCredential.user;

    if (kDebugMode) {
      print('User signed in firebase uid: ${firebaseUser?.uid}');
    }

    return userCredential;
  } catch (e) {
    if (kDebugMode) {
      print('Error Occurred: $e');
    }
    throw Exception('Failed to sign in with Apple: $e');
  }
}
