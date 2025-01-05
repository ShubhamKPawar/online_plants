// Enum and extension for theme generation
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum ThemeEnum { DARK, LIGHT }

extension ThemeEnumExtension on ThemeEnum {
  ThemeData get generateTheme {
    switch (this) {
      case ThemeEnum.LIGHT:
        return ThemeData();
      case ThemeEnum.DARK:
        return ThemeData();
      default:
        return ThemeData();
    }
  }
}
