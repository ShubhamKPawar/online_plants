// Enum and extension for theme generation
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_light.dart';

enum ThemeEnum { DARK, LIGHT }

extension ThemeEnumExtension on ThemeEnum {
  ThemeData get generateTheme {
    switch (this) {
      case ThemeEnum.LIGHT:
        return ThemeLight.instance.theme!;
      case ThemeEnum.DARK:
        return ThemeLight.instance.theme!;
      default:
        return ThemeLight.instance.theme!;
    }
  }
}
