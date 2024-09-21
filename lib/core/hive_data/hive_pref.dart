import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:online_plants_app/core/hive_data/hive_const.dart';
import 'package:path_provider/path_provider.dart';

class HivePreference {
  final Box<dynamic> _box;
  HivePreference._(
    this._box,
  );

  static Future<HivePreference> getInstance() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final box = await Hive.openBox<dynamic>(HiveConstants.kuserbox);

    return HivePreference._(
      box,
    );
  }

  Future<void> deleteBox(String name) async {
    await Hive.deleteBoxFromDisk(name);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  //To check if is login
  bool getIsLogging() =>
      _getValue(HiveConstants.isLoggedIn, defaultValue: false);

  Future<void> setIsLogging(bool value) =>
      _setValue(HiveConstants.isLoggedIn, value);

  //GUEST LOGIN
  bool? getIsGuest() => _getValue(HiveConstants.isGuest, defaultValue: null);

  Future<void> setIsGuest(bool value) =>
      _setValue(HiveConstants.isGuest, value);

  //To check if is remember data
  Map getRememberData() =>
      _getValue(HiveConstants.loginDataRemember, defaultValue: {});

  Future<void> setRememberData(Map value) =>
      _setValue<Map>(HiveConstants.loginDataRemember, value);

  //To getLogged-in user id
  String getUserId() => _getValue(HiveConstants.userId, defaultValue: "0");

  Future<void> setUserId(dynamic value) =>
      _setValue(HiveConstants.userId, value);

  //To getLogged-in user name
  String getUserName() => _getValue(HiveConstants.username, defaultValue: "0");

  Future<void> setUserName(dynamic value) =>
      _setValue(HiveConstants.username, value);

  String getUserEmail() =>
      _getValue(HiveConstants.userEmail, defaultValue: "0");

  Future<void> setUserEmail(dynamic value) =>
      _setValue(HiveConstants.userEmail, value);

  Future clearAllData() async {
    await Hive.box(HiveConstants.kuserbox).clear();
  }

  // dynamic getCountries() {
  //   String? countries = _getValue(HiveConstants.countryData);
  //   if ((countries ?? "").isNotEmpty) {
  //     var response = jsonDecode(countries!);
  //     return response;
  //   }
  //   return <dynamic>[];
  // }

  // setCountryData(String value) {
  //   _setValue(HiveConstants.countryData, value);
  // }
}
