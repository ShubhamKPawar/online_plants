import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';

TextTheme createTextTheme(bool isLight) {
  TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        fontSize: (0.9) * 57,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    displayMedium: TextStyle(
        fontSize: (0.9) * 45,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    displaySmall: TextStyle(
        fontSize: (0.9) * 36,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    headlineLarge: TextStyle(
        fontSize: (0.9) * 32,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    headlineMedium: TextStyle(
        fontSize: (0.9) * 24,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    headlineSmall: TextStyle(
        fontSize: (0.9) * 18,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    titleLarge: TextStyle(
        fontSize: (0.9) * 22,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    titleMedium: TextStyle(
        fontSize: (0.9) * 18,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    titleSmall: TextStyle(
        fontSize: (0.9) * 14,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    bodyLarge: TextStyle(
        fontSize: (0.9) * 16,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    bodyMedium: TextStyle(
        fontSize: (0.9) * 14,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    bodySmall: TextStyle(
        fontSize: (0.9) * 12,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    labelLarge: TextStyle(
        fontSize: (0.9) * 14,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    labelMedium: TextStyle(
        fontSize: (0.9) * 12,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
    labelSmall: TextStyle(
        fontSize: (0.9) * 10,
        color: isLight ? AppColor.skWhite : AppColor.skGreenColor),
  );
  return textTheme;
}
