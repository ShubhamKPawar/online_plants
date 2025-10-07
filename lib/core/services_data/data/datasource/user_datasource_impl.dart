import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/services_data/data/datasource/user_datasource.dart';
import 'package:online_plants_app/core/services_data/model/user_model.dart';

class UserDatasourceImpl extends UserDatasource {
  final HivePref hivePref;
  UserDatasourceImpl({required this.hivePref});

  @override
  Future<UserModel?> getUserDetail(String id, String email) async {
    try {
      print('here two ....');
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection('Users').doc(id);
      DocumentSnapshot userDoc = await userDocRef.get();
      print('user dioc ${userDoc.toString()}');
      if (!userDoc.exists) {
        print('user not exists....');
        return null;
      } else {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        UserModel model = UserModel.fromJson(userData);
        if (model.email == email) return model;
        print('nullll');
        return null;
      }
    } catch (e) {
      print('exception..');
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> setUserDetail(UserModel userModel) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef =
          firestore.collection('Users').doc(userModel.id);

      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        await userDocRef.set(userModel.toJson());
      } else {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        UserModel prevModel = UserModel.fromJson(userData);

        UserModel newModel = UserModel(
          id: prevModel.id,
          email: userModel.email,
          username: userModel.username,
          mobileNumber: userModel.mobileNumber,
          isAdmin: userModel.isAdmin,
          nurseryDetails: userModel.nurseryDetails,
          createdDate: userModel.createdDate,
          updatedDate: DateTime.now().toIso8601String(),
          password: prevModel.password,
        );
        await userDocRef.update(newModel.toJson());
      }

      DocumentSnapshot updatedUserDoc = await userDocRef.get();
      if (updatedUserDoc.exists) {
        Map<String, dynamic> userData =
            updatedUserDoc.data() as Map<String, dynamic>;
        UserModel model = UserModel.fromJson(userData);
        return model;
      } else {
        throw Exception('User document not found after update');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> changeUserPassword(
      String email, String prevPassword, String currentPassword) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String uid = hivePref.getUserId();
      String uEmail = hivePref.getUserEmail();
      if (uEmail != email) throw Exception('Wrong user details');

      DocumentReference userDocRef = firestore.collection('Users').doc(uid);

      DocumentSnapshot userDoc = await userDocRef.get();

      if (!userDoc.exists) {
        throw Exception('No user found...');
      } else {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        UserModel prevModel = UserModel.fromJson(userData);
        if (prevModel.email != email)
          throw Exception('Wrong user details, Please login again');
        if (prevModel.password != prevPassword)
          throw Exception('Previous password not matched');
        UserModel newModel = UserModel(
          id: prevModel.id,
          email: prevModel.email,
          username: prevModel.username,
          mobileNumber: prevModel.mobileNumber,
          isAdmin: prevModel.isAdmin,
          nurseryDetails: prevModel.nurseryDetails,
          createdDate: prevModel.createdDate,
          updatedDate: DateTime.now().toIso8601String(),
          password: currentPassword,
        );
        await userDocRef.update(newModel.toJson());
      }

      DocumentSnapshot updatedUserDoc = await userDocRef.get();
      if (updatedUserDoc.exists) {
        Map<String, dynamic> userData =
            updatedUserDoc.data() as Map<String, dynamic>;
        UserModel model = UserModel.fromJson(userData);
        return true;
      } else {
        throw Exception('User document not found after update');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
