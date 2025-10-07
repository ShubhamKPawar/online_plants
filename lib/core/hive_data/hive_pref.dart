import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:online_plants_app/core/hive_data/hive_const.dart';
import 'package:online_plants_app/core/hive_data/product_color.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';
import 'package:online_plants_app/core/services_data/model/user_model.dart';
import 'package:path_provider/path_provider.dart';

class HivePref {
  final Box<dynamic> _box;
  final Box<dynamic> _preferences;
  final Box<UserModel> _userBox;
  final Box<SellerModel> _sellerBox;
  final Box<ProductColor> _productColor;
  HivePref._(
    this._box,
    this._preferences,
    this._userBox,
    this._sellerBox,
    this._productColor,
  );

  static Future<HivePref> getInstance() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(NurseryDetailAdapter());

    Hive.registerAdapter(SellerModelAdapter());
    Hive.registerAdapter(AddressModelAdapter());

    Hive.registerAdapter(ProductColorAdapter());

    final box = await Hive.openBox<dynamic>(HiveConstants.kUserbox);
    final preferences =
        await Hive.openBox<dynamic>(HiveConstants.kUserPreferences);

    Box<UserModel>? userBox =
        await Hive.openBox<UserModel>(HiveConstants.kUserDetailBox);

    Box<SellerModel>? sellerBox =
        await Hive.openBox<SellerModel>(HiveConstants.kSellerDetailBox);

    Box<ProductColor>? productColor =
        await Hive.openBox<ProductColor>(HiveConstants.kProductColorBox);

    return HivePref._(
      box,
      preferences,
      userBox,
      sellerBox,
      productColor,
    );
  }

  Future<void> clearAllData() async {
    await Hive.box(HiveConstants.kUserbox).clear();
  }

  Future<void> deleteBox(String name) async {
    await Hive.deleteBoxFromDisk(name);
  }

  T _getValue<T>(dynamic key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);

  //To check if is login
  bool getIsLoggedIn() =>
      _getValue(HiveConstants.isLoggedIn, defaultValue: false);

  Future<void> setIsLoggedIn(bool value) =>
      _setValue(HiveConstants.isLoggedIn, value);

  //GUEST LOGIN
  bool? getIsGuest() => _getValue(HiveConstants.isGuest, defaultValue: null);

  Future<void> setIsGuest(bool value) =>
      _setValue(HiveConstants.isGuest, value);

  //To check if is remember data
  Map<String, dynamic> getRememberData() =>
      _getValue(HiveConstants.loginDataRemember, defaultValue: {});

  Future<void> setRememberData(Map<String, dynamic> value) =>
      _setValue<Map>(HiveConstants.loginDataRemember, value);

  //To getLogged-in user id
  String getUserId() => _getValue(HiveConstants.userId, defaultValue: "");

  Future<void> setUserId(dynamic value) =>
      _setValue(HiveConstants.userId, value);

  //To getLogged-in user name
  String getUserName() => _getValue(HiveConstants.username, defaultValue: "");

  Future<void> setUserName(dynamic value) =>
      _setValue(HiveConstants.username, value);

//mobile no
  String getUserMobileNo() =>
      _getValue(HiveConstants.mobileNo, defaultValue: "");

  Future<void> setUserMobileNo(dynamic value) =>
      _setValue(HiveConstants.mobileNo, value);

  //email
  String getUserEmail() => _getValue(HiveConstants.userEmail, defaultValue: "");

  Future<void> setUserEmail(dynamic value) =>
      _setValue(HiveConstants.userEmail, value);

  Future<void> setLoginImages(List<String> loginImages) async {
    if (!_box.containsKey(HiveConstants.loginImages)) {
      _setValue(HiveConstants.loginImages, loginImages);
    }
    return;
  }

  Future<bool> containsLogginImages() async {
    return _box.containsKey(HiveConstants.loginImages);
  }

  Future<List<String>> getLoginImages() async {
    return _getValue(HiveConstants.loginImages, defaultValue: [])
        as List<String>;
  }

  Future<void> setCompletedUserDetails(UserModel model) async {
    _userBox.put(model.email, model);
  }

  Future<UserModel?> getCompleteUserDetails(String email) async {
    return _userBox.get(email);
  }

  Future<UserModel?> getCurrentUserDetails() async {
    String email = getUserEmail();
    if (email.isNotEmpty) {
      return getCompleteUserDetails(email);
    }
    return null;
  }

  Future<void> setSellerDetail(SellerModel model) async {
    if (_sellerBox.containsKey(model.id)) {
      return;
    }
    _sellerBox.put(model.id, model);
  }

  Future<SellerModel?> getSellerDetail(String id) async {
    List<SellerModel> sellers = _sellerBox.values.toList().cast<SellerModel>();
    if (sellers.isEmpty) return null;
    return sellers.firstWhere((test) => test.id == id);
  }

  Future<void> setDarkMode(bool isDarkMode) async {
    await _preferences.put(HiveConstants.appTheme, isDarkMode);
  }

  bool getThemeMode() {
    final appTheme =
        _preferences.get(HiveConstants.appTheme, defaultValue: false);
    return appTheme;
  }

  Future<void> saveLocale(Locale locale) async {
    await _preferences.put(HiveConstants.appLocale, locale.languageCode);
  }

  Locale getSavedLocale() {
    final languageCode =
        _preferences.get(HiveConstants.appLocale, defaultValue: 'en');
    if (languageCode.isEmpty) {
      return PlatformDispatcher.instance.locale;
    }
    return Locale(languageCode);
  }

  Future<void> setNotification(bool value) async {
    await _preferences.put(HiveConstants.appNotification, value);
  }

  bool getNotification() {
    return _preferences.get(HiveConstants.appNotification, defaultValue: true);
  }

  Future<void> setLocation(bool value) async {
    await _preferences.put(HiveConstants.userLocation, value);
  }

  bool getLocation() {
    return _preferences.get(HiveConstants.userLocation, defaultValue: true);
  }

  Future<void> addProductColor(ProductColor model) async {
    try {
      // Update or add the recent video model
      if (_productColor.containsKey(model.url ?? 'color')) {
        return;
        // // If it exists, update its updatedDate to the current time.
        // final existingModel =
        //     _productColor.get(model.url ?? 'color') as ProductColor;
        // final updatedModel =
        //     existingModel.copyWith(color: model.color ?? existingModel.color);
        // await _productColor.put(model.url ?? 'color', updatedModel);
      } else {
        await _productColor.put(model.url ?? 'color', model);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addMultipleProductColor(List<ProductColor> models) async {
    try {
      final entries = {for (var model in models) model.url ?? 'color': model};
      await _productColor.putAll(entries);
    } catch (e) {
      throw Exception('Err in multy recent add $e');
    }
  }

  Future<void> removeProductColor({String url = 'color'}) async {
    try {
      _productColor.delete(url);
    } catch (e) {
      throw Exception('Err in recent remove $e');
    }
  }

  Future<void> removeAllProductColor() async {
    try {
      _productColor.clear();
    } catch (e) {
      throw Exception('Err in remove all recent $e');
    }
  }

  Future<ProductColor?> getProudctColor({String url = 'color'}) async {
    try {
      ProductColor? model = _productColor.get(url,
          defaultValue:
              ProductColor(url: url, color: const Color(0xff2b2b2b).value));
      return model;
    } catch (e) {
      throw Exception('Err in get recent by key $e');
    }
  }

  Future<List<ProductColor>> getAllProductColors() async {
    try {
      return _productColor.values.toList().cast<ProductColor>();
    } catch (e) {
      throw Exception('Err in get all product colors $e');
    }
  }
}
