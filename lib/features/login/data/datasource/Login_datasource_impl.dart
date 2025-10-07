import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/services_data/model/user_model.dart';
import 'package:online_plants_app/features/login/data/datasource/login_datasource.dart';
import 'package:online_plants_app/features/login/data/datasource/sign_in_helper.dart';

class LoginDatasourceImpl extends LoginDatasource {
  final HivePref hivePref;
  LoginDatasourceImpl({required this.hivePref});

  @override
  Future<List<String>> getLoginImages() async {
    try {
      bool containsImages = await hivePref.containsLogginImages();
      if (!containsImages) {
        CollectionReference backupsRef = FirebaseFirestore.instance
            .collection('cloud_images')
            .doc(Constants.goreshwarId)
            .collection('images');

        // Fetch documents and map to a list of URLs
        var snapshot = await backupsRef.get();
        List<String> imageUrls =
            snapshot.docs.map((doc) => doc['image_url'] as String).toList();
        hivePref.setLoginImages(imageUrls);
        return imageUrls;
      } else {
        List<String> images = await hivePref.getLoginImages();
        return images;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error fetching images: $e  .. ${stackTrace.toString()}');
      }
      return [];
    }
  }

  @override
  Future<dynamic> loginUsingEmailAndPass({
    required String email,
    required String password,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential? userCredential =
          await userLogin(email: email, password: password);
      if (userCredential != null && userCredential.user != null) {
        String uid = userCredential.user!.uid;
        DocumentReference userDocRef = firestore.collection('Users').doc(uid);

        DocumentSnapshot userDoc = await userDocRef.get();

        if (!userDoc.exists) {
          final now = DateTime.now().toIso8601String();
          UserModel userModel = UserModel(
            id: uid,
            email: userCredential.user?.email ?? email,
            username: userCredential.user?.displayName ?? password,
            mobileNumber: userCredential.user?.phoneNumber ?? '',
            isAdmin: false,
            nurseryDetails: [NurseryDetail(id: Constants.goreshwarId)],
            password: password,
            createdDate: now,
            updatedDate: now,
          );
          await userDocRef.set(userModel.toJson());
        } else {
          await userDocRef.update({
            'updated_date': DateTime.now().toIso8601String(),
          });
        }

        DocumentSnapshot updatedUserDoc = await userDocRef.get();
        if (updatedUserDoc.exists) {
          Map<String, dynamic> userData =
              updatedUserDoc.data() as Map<String, dynamic>;
          UserModel model = UserModel.fromJson(userData);
          hivePref.setIsLoggedIn(true);
          hivePref.setIsGuest(false);
          hivePref.setUserId(model.id);
          hivePref.setUserEmail(model.email);
          hivePref.setUserName(model.username);
          hivePref.setUserMobileNo(model.mobileNumber);
          hivePref.setCompletedUserDetails(model);
          return true;
        } else {
          throw Exception('User document not found after update');
        }
      }
      throw Exception('Something went wrong');
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<dynamic> registerNewUser({
    required String email,
    required String password,
    required String userName,
    required String mobileNo,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential? userCredential = await userRegister(
        email: email,
        password: password,
        userName: userName,
      );

      if (userCredential != null && userCredential.user != null) {
        String uid = userCredential.user!.uid;
        await userCredential.user!.updateDisplayName(userName);

        final now = DateTime.now().toIso8601String();
        DocumentReference userDocRef = firestore.collection('Users').doc(uid);
        UserModel userModel = UserModel(
          id: uid,
          email: email,
          username: userName,
          mobileNumber: mobileNo,
          isAdmin: false,
          nurseryDetails: [NurseryDetail(id: Constants.goreshwarId)],
          password: password,
          createdDate: now,
          updatedDate: now,
        );

        await userDocRef.set(userModel.toJson());

        DocumentSnapshot userDoc = await userDocRef.get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          UserModel model = UserModel.fromJson(userData);
          hivePref.setIsLoggedIn(true);
          hivePref.setIsGuest(false);
          hivePref.setUserId(model.id);
          hivePref.setUserEmail(model.email);
          hivePref.setUserName(model.username);
          hivePref.setUserMobileNo(model.mobileNumber);
          hivePref.setCompletedUserDetails(model);
          return true;
        } else {
          throw Exception('User document not found after creation');
        }
      }
      throw Exception('Something went wrong');
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<dynamic> signInWithGoogleId() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential? credential = await userSignInWithGoogle();
      if (credential != null && credential.user != null) {
        String uid = credential.user!.uid;
        DocumentReference userDocRef = firestore.collection('Users').doc(uid);

        final now = DateTime.now().toIso8601String();
        DocumentSnapshot userDoc = await userDocRef.get();

        if (!userDoc.exists) {
          UserModel userModel = UserModel(
            id: uid,
            email: credential.user?.email ?? '',
            username: credential.user?.displayName ?? '',
            mobileNumber: credential.user?.phoneNumber ?? '',
            isAdmin: false,
            nurseryDetails: [NurseryDetail(id: Constants.goreshwarId)],
            password: 'google',
            createdDate: now,
            updatedDate: now,
          );

          await userDocRef.set(userModel.toJson());
        } else {
          await userDocRef.update({'updated_date': now});
        }

        DocumentSnapshot updatedUserDoc = await userDocRef.get();
        if (updatedUserDoc.exists) {
          Map<String, dynamic> userData =
              updatedUserDoc.data() as Map<String, dynamic>;
          UserModel model = UserModel.fromJson(userData);
          hivePref.setIsLoggedIn(true);
          hivePref.setIsGuest(false);
          hivePref.setUserId(model.id);
          hivePref.setUserEmail(model.email);
          hivePref.setUserName(model.username);
          hivePref.setUserMobileNo(model.mobileNumber);
          hivePref.setCompletedUserDetails(model);
          return true;
        } else {
          throw Exception('User document not found after update');
        }
      }
      throw Exception('Something went wrong');
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  @override
  Future<dynamic> signInWithAppleId() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential? userCredential = await userSignInApple();
      if (userCredential != null && userCredential.user != null) {
        String uid = userCredential.user!.uid;
        DocumentReference userDocRef = firestore.collection('Users').doc(uid);

        final now = DateTime.now().toIso8601String();
        DocumentSnapshot userDoc = await userDocRef.get();

        if (!userDoc.exists) {
          UserModel userModel = UserModel(
            id: uid,
            email: userCredential.user?.email ?? '',
            username: userCredential.user?.displayName ?? '',
            mobileNumber: userCredential.user?.phoneNumber ?? '',
            isAdmin: false,
            nurseryDetails: [NurseryDetail(id: Constants.goreshwarId)],
            password: 'apple',
            createdDate: now,
            updatedDate: now,
          );

          await userDocRef.set(userModel.toJson());
        } else {
          await userDocRef.update({'updated_date': now});
        }

        DocumentSnapshot updatedUserDoc = await userDocRef.get();
        if (updatedUserDoc.exists) {
          Map<String, dynamic> userData =
              updatedUserDoc.data() as Map<String, dynamic>;
          UserModel model = UserModel.fromJson(userData);
          hivePref.setIsLoggedIn(true);
          hivePref.setIsGuest(false);
          hivePref.setUserId(model.id);
          hivePref.setUserEmail(model.email);
          hivePref.setUserName(model.username);
          hivePref.setUserMobileNo(model.mobileNumber);
          hivePref.setCompletedUserDetails(model);
          return true;
        } else {
          throw Exception('User document not found after update');
        }
      }
      throw Exception('Something went wrong');
    } catch (e) {
      throw Exception('Apple sign-in failed: $e');
    }
  }
}


  // Future<List<String>> getImageUrls() async {
  //   List<String> imageUrls = [];
  //   try {
  //     // Define storage references
  //     final storage = FirebaseStorage.instance;

  //     final List<String> paths = [
  //       'Seller_Images/Address_Images/digu_56',
  //       'Seller_Images/Main_Images/digu_56',
  //     ];

  //     for (String path in paths) {
  //       final ref = storage.ref(path);
  //       final ListResult result = await ref.listAll();

  //       for (var item in result.items) {
  //         String url = await item.getDownloadURL();
  //         print('path $path ....  urls... $url');
  //         imageUrls.add(url);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching images: $e');
  //   }
  //   return imageUrls;
  // }
