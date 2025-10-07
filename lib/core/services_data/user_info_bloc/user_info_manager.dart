import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';

class UserInfoManager extends Cubit<UserInfoManageState> {
  final HivePref hivePref;

  // Declare nullable variables and initialize properly
  String userId = '';
  bool isGuest = true;
  bool isLoggedIn = false;
  String userName = '';
  String userEmail = '';
  String userMobileNo = '';
  bool isNotification = true;
  bool isLocation = true;

  UserInfoManager(this.hivePref) : super(UserInfoManageState.fail) {
    getUserData();
  }

  void getUserData() {
    userId = hivePref.getUserId();
    isGuest = hivePref.getIsGuest() ?? true;
    isLoggedIn = hivePref.getIsLoggedIn();
    userName = hivePref.getUserName();
    userEmail = hivePref.getUserEmail();
    userMobileNo = hivePref.getUserMobileNo();
    isNotification = hivePref.getNotification();
    isLocation = hivePref.getLocation();
    emitData();
  }

  emitData() {
    if (userId.isNotEmpty && isLoggedIn) {
      emit(UserInfoManageState.success);
    } else {
      emit(UserInfoManageState.fail);
    }
  }

  void activeNotification() async {
    emit(UserInfoManageState.loading); // Temporary state
    await hivePref.setNotification(true);
    isNotification = true; // Ensure local variable updates correctly
    emit(UserInfoManageState.notification); // Emit state change
  }

  void inactiveNotification() async {
    emit(UserInfoManageState.loading); // Temporary state
    await hivePref.setNotification(false);
    isNotification = false; // Ensure local variable updates correctly
    emit(UserInfoManageState.notification); // Emit state change
  }

  void activeLocation() async {
    emit(UserInfoManageState.loading); // Temporary state
    await hivePref.setLocation(true);
    isLocation = true; // Update local variable
    emit(UserInfoManageState.location); // Final state
  }

  void inactiveLocation() async {
    emit(UserInfoManageState.loading); // Temporary state
    await hivePref.setLocation(false);
    isLocation = false; // Update local variable
    emit(UserInfoManageState.location); // Final state
  }

  void checkLoggedIn() async {
    emit(UserInfoManageState.loading); // Temporary state
    isLoggedIn = hivePref.getIsLoggedIn();
    emit(UserInfoManageState.loggedIn); // Final state
  }
}

enum UserInfoManageState {
  loading,
  success,
  fail,
  notification,
  location,
  loggedIn;
}
