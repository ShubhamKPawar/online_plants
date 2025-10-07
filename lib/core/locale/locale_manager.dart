import 'dart:developer';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';

class LocaleManager extends Cubit<Locale> {
  final HivePref hivePref;

  LocaleManager(this.hivePref) : super(PlatformDispatcher.instance.locale);

  String currentLanguage =
      getLocale(PlatformDispatcher.instance.locale.languageCode);

  void loadLocale() async {
    Locale locale = hivePref.getSavedLocale();

    currentLanguage = getLocale(locale.languageCode);
    emit(locale);

    // log('Current app Locale --> ${locale.languageCode}');
    // log('Current GraphQL Locale --> ${GraphQlClient.appLocale.languageCode}');
    // log('Current Shop GraphQL Locale --> ${ShopGraphqlClient.appLocale.languageCode}');
  }

  void changeLocale(Locale locale) async {
    // log("Lang --> ${locale.toLanguageTag()}");
    // log("Lang --> ${locale.toString()}");
    currentLanguage = getLocale(locale.languageCode);
    hivePref.saveLocale(locale);

    emit(locale);
  }
}

String getLocale(String locale) {
  // Get the preferred locales from the device.
  //final langCode=locale.split(',').map((lang) => lang.split('-')[0]).toList().first;
  final langCode = locale.split('-').first; // Extract the language code.
  // // Check if the language code is in supported locales.
  // if (Strings.supportedLocales
  //     .any((supportedLocale) => supportedLocale.languageCode == langCode)) {
  //   return langCode; // Return the matching language code if found.
  // }
  // Default to 'en' if no supported locale is found.
  // return "en";
  return 'en';
}
