import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/theme/app_theme.dart';

class ThemeDark extends ApplicationTheme {
  static ThemeDark? _instance;
  static ThemeDark get instance {
    _instance ??= ThemeDark._init();
    return _instance!;
  }

  ThemeDark._init();

  @override
  ThemeData? get theme => ThemeData(
        primaryColor: Colors.white,
        primaryColorLight: const Color(0xff9e9e9e),
        primaryColorDark: Colors.black,
        canvasColor: const Color.fromARGB(255, 30, 30, 30),
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
        cardColor: const Color(0xff424242),
        dividerColor: const Color(0x1fffffff),
        highlightColor: const Color(0x40cccccc),
        splashColor: const Color(0x40cccccc),
        unselectedWidgetColor: const Color(0xb3ffffff),
        disabledColor: const Color(0x62ffffff),
        secondaryHeaderColor: const Color(0xff616161),
        dialogBackgroundColor: const Color(0xff424242),
        indicatorColor: const Color(0xff64ffda),
        primarySwatch: const MaterialColor(
          0xFFFFFFFF,
          <int, Color>{
            50: Color(0xFFFFFFFF),
            100: Color(0xFFFFFFFF),
            200: Color(0xFFFFFFFF),
            300: Color(0xFFFFFFFF),
            400: Color(0xFFFFFFFF),
            500: Color(0xFFFFFFFF),
            600: Color(0xFFFFFFFF),
            700: Color(0xFFFFFFFF),
            800: Color(0xFFFFFFFF),
            900: Color(0xFFFFFFFF),
          },
        ),
        hintColor: const Color(0x80ffffff),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          minWidth: 88,
          height: 36,
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          displayMedium: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          displaySmall: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headlineMedium: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headlineSmall: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleLarge: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleMedium: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyLarge: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyMedium: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodySmall: TextStyle(
            color: Color(0xb3ffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          labelLarge: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleSmall: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          labelSmall: TextStyle(
            color: Color(0xffffffff),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
          trackColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return const Color(0xff64ffda);
            }
            return null;
          }),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff424242)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        )),
        colorScheme: ColorScheme.fromSwatch(
                brightness: Brightness.dark,
                primarySwatch: const MaterialColor(4280361249, {
                  50: Color(0xfff2f2f2),
                  100: Color(0xffe6e6e6),
                  200: Color(0xffcccccc),
                  300: Color(0xffb3b3b3),
                  400: Color(0xff999999),
                  500: Color(0xff808080),
                  600: Color(0xff666666),
                  700: Color(0xff4d4d4d),
                  800: Color(0xff333333),
                  900: Color(0xff191919)
                }))
            .copyWith(surface: const Color(0xff616161))
            .copyWith(error: const Color(0xffd32f2f)),
      );
}
