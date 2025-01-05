import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/features/login/data/datasource/login_datasource.dart';
import 'package:online_plants_app/features/login/data/datasource/sign_in_helper.dart';

class LoginDatasourceImpl extends LoginDatasource {
  @override
  Future<List<String>> getLoginImages() async {
    try {
      // Reference to Firestore subcollection
      CollectionReference backupsRef = FirebaseFirestore.instance
          .collection('cloud_images')
          .doc('goreshwar')
          .collection('images');

      // Fetch documents and map to a list of URLs
      var snapshot = await backupsRef.get();
      List<String> imageUrls =
          snapshot.docs.map((doc) => doc['image_url'] as String).toList();

      return imageUrls;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching images: $e  .. ${stackTrace.toString()}');
      }
      return [];
    }
  }

  @override
  Future<UserCredential?> loginUsingEmailAndPass(
      {required String email, required String password}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential? userCredential =
          await userLogin(email: email, password: password);
      if (userCredential != null && userCredential.user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore
            .collection('Users')
            .doc(userCredential.user?.uid ?? "-1")
            .get();
        if (!userDoc.exists) {
          await firestore
              .collection('Users')
              .doc(userCredential.user?.uid ?? '-1')
              .set({
            'email': userCredential.user?.email ?? '',
            'username': userCredential.user?.displayName ?? '',
            'isAdmin': false,
            'nersery_details': {
              'id': 1,
              'name': 'goreshwar nersery',
              'owner': 'shubham pawar'
            },
          });
        }
        hiveInstance?.setIsLoggin(true);
        hiveInstance?.setIsGuest(false);
        hiveInstance?.setUserId(userCredential.user?.uid ?? '');
        hiveInstance?.setUserEmail(userCredential.user?.email ?? '');
        hiveInstance?.setUserName(userCredential.user?.displayName ?? '');

        print('USER LOGIN : ${userDoc.data().toString()}');
      }
      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential?> registerNewUser(
      {required String email,
      required String password,
      required String userName}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      print('data register $email $password $userName');
      UserCredential? userCredential = await userRegister(
          email: email, password: password, userName: userName);

      if (userCredential != null && userCredential.user != null) {
        print('HERREE');
        await userCredential.user!.updateDisplayName(userName);
        hiveInstance?.setIsLoggin(true);
        hiveInstance?.setIsGuest(false);
        hiveInstance?.setUserId(userCredential.user?.uid ?? '');
        hiveInstance?.setUserEmail(userCredential.user?.email ?? email);
        hiveInstance?.setUserName(userCredential.user?.displayName ?? userName);
        try {
          await firestore
              .collection('Users')
              .doc(userCredential.user?.uid ?? '')
              .set({
            'email': userCredential.user?.email ?? email,
            'username': userCredential.user?.displayName ?? userName,
            'isAdmin': false,
            'nersery_details': {
              'id': 1,
              'name': 'goreshwar nersery',
              'owner': 'shubham pawar'
            },
          });
        } catch (e) {
          if (kDebugMode) print('REGISTER ERROR >> $e');
        }
      }
    } on FirebaseException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  @override
  Future<UserCredential?> signInWithGoogleId() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential? credential = await userSignInWithGoogle();
      if (credential != null && credential.user != null) {
        // Check if user exists in Firestore
        DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore
            .collection('Users')
            .doc(credential.user?.uid ?? '-1')
            .get();

        if (!userDoc.exists) {
          await firestore
              .collection('Users')
              .doc(credential.user?.uid ?? '-1')
              .set({
            'email': credential.user?.email ?? '',
            'username': credential.user?.displayName ?? '',
            'isAdmin': false,
            'nersery_details': {
              'id': 1,
              'name': 'goreshwar nersery',
              'owner': 'shubham pawar'
            },
          });
        }
        DocumentSnapshot<Map<String, dynamic>> userDocAgain = await firestore
            .collection('Users')
            .doc(credential.user?.uid ?? '-1')
            .get();

        hiveInstance?.setIsLoggin(true);
        hiveInstance?.setIsGuest(false);
        hiveInstance?.setUserId(credential.user?.uid ?? '');
        hiveInstance?.setUserEmail(credential.user?.email ?? '');
        hiveInstance?.setUserName(credential.user?.displayName ?? '');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception("email-already-in-use");
      }
      throw Exception(e);
    } catch (e) {
      if (kDebugMode) {
        print('Error Occurred..$e');
      }
      throw Exception(e);
    }
    return null;
  }

  @override
  Future<UserCredential?> signInWithAppleId() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential? userCredential = await userSignInApple();
      if (userCredential != null && userCredential.user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await firestore
            .collection('Users')
            .doc(userCredential.user?.uid ?? '-1')
            .get();

        if (!userDoc.exists) {
          await firestore
              .collection('Users')
              .doc(userCredential.user?.uid ?? '-1')
              .set({
            'email': userCredential.user?.email ?? '',
            'username': userCredential.user?.displayName ?? '',
            'isAdmin': false,
            'nersery_details': {
              'id': 1,
              'name': 'goreshwar nersery',
              'owner': 'shubham pawar'
            },
          });
        }
        DocumentSnapshot<Map<String, dynamic>> userDocAgain = await firestore
            .collection('Users')
            .doc(userCredential.user?.uid ?? '-1')
            .get();

        hiveInstance?.setIsLoggin(true);
        hiveInstance?.setIsGuest(false);
        hiveInstance?.setUserId(userCredential.user?.uid ?? '');
        hiveInstance?.setUserEmail(userCredential.user?.email ?? '');
        hiveInstance?.setUserName(userCredential.user?.displayName ?? '');
      }
    } catch (e) {}
    return null;
  }
}
