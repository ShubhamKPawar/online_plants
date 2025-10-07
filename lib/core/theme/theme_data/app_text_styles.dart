import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  const AppTextStyles._();

  static const familyPoppins = "Poppins";
  static const familyBarlow = "Barlow";
  static const familyPlusJakarta = "Plus Jakarta";
  static const familyGrandisExtended = "Grandis Extended";
  static const familyHelvetica = "Helvetica";
  static const familyMeditative = "Meditative";

  static const primaryFontFamily = familyPlusJakarta;
  static const numberFontFamily = familyMeditative;
  static const fontFamilyFallback = ["Barlow"];

  //12 400
  static TextStyle labelSmall({required Color textColor}) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.5,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//16 400
  static TextStyle labelMedium({required Color textColor}) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//18 400
  static TextStyle labelLarge({required Color textColor}) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 1.2,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//12 600
  static TextStyle titleSmall({required Color textColor}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//16 600
  static TextStyle titleMedium({
    required Color textColor,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.2,
      color: textColor,
      letterSpacing: -0.6,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: const [primaryFontFamily, ...fontFamilyFallback],
    );
  }

//22 600
  static TextStyle titleLarge({required Color textColor}) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      height: 1,
      letterSpacing: -.6,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//20 600
  static TextStyle displaySmall({
    required Color textColor,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 1,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//25 500
  static TextStyle displayMedium({
    required Color textColor,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//28 600
  static TextStyle displayLarge({
    required Color textColor,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 28,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//12 500
  static TextStyle bodySmall({required Color textColor}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.2,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//14 500
  static TextStyle bodyMedium({
    required Color textColor,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//18 500
  static TextStyle bodyLarge({
    required Color textColor,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 1.2,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//18 900

  static TextStyle homeCirclesText({
    required Color textColor,
  }) {
    return TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 18,
      height: 1.2,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//18 500
  static TextStyle headlineLarge({required Color textColor}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 1.2,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//16 500
  static TextStyle headlineMedium({required Color textColor}) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.2,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }

//15 500
  static TextStyle headlineSmall({required Color textColor}) {
    return TextStyle(
      fontSize: 15,
      height: 1.2,
      letterSpacing: 0.0,
      color: textColor,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: primaryFontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );
  }
}
