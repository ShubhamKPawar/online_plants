import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_colors.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/theme/app_theme.dart';

class ThemeLight extends ApplicationTheme {
  static ThemeLight? _instance;

  static ThemeLight get instance {
    _instance ??= ThemeLight._init();
    return _instance!;
  }

  ThemeLight._init();

  @override
  ThemeData? get theme => ThemeData(
        primaryColor: Colors.black,
        primaryColorLight: const Color(0xffd8d1fa),
        primaryColorDark: Colors.white,
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        cardTheme: const CardTheme(
            color: Colors.white, elevation: 5, shadowColor: Colors.black45),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.white),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.kRed,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          hintStyle: const TextStyle(color: AppColors.kTextFieldHintColor),
          fillColor: AppColors.kTextFieldFillColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                const BorderSide(color: AppColors.kTextFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.kRed),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                const BorderSide(color: AppColors.kTextFieldBorderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.kBlack),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        primarySwatch: const MaterialColor(
          0xFFFFFFFF,
          <int, Color>{
            50: Color(0xFF000000),
            100: Color(0xFF000000),
            200: Color(0xFF000000),
            300: Color(0xFF000000),
            400: Color(0xFF000000),
            500: Color(0xFF000000),
            600: Color(0xFF000000),
            700: Color(0xFF000000),
            800: Color(0xFF000000),
            900: Color(0xFF000000),
          },
        ),
        dividerColor: const Color(0x1f000000),
        highlightColor: Colors.grey,
        splashColor: Colors.grey,
        unselectedWidgetColor: const Color(0x8a000000),
        disabledColor: const Color(0x61000000),
        secondaryHeaderColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        indicatorColor: const Color(0x8a000000),
        hintColor: const Color(0x8a000000),
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.normal,
          minWidth: 88,
          height: 36,
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff000000),
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0x8a000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          displayMedium: TextStyle(
            color: Color(0x8a000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          displaySmall: TextStyle(
            color: Color(0x8a000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headlineMedium: TextStyle(
            color: Color(0x8a000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          headlineSmall: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleLarge: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleMedium: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyLarge: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodyMedium: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          bodySmall: TextStyle(
            color: Color(0x8a000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          labelLarge: TextStyle(
            color: Color(0xdd000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          titleSmall: TextStyle(
            color: Color(0xff000000),
            fontSize: null,
            fontFamily: fontFamilyCustom,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
          ),
          labelSmall: TextStyle(
            color: Color(0xff000000),
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
              return Colors.black;
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
              return Colors.black;
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
              return const Color(0xff2f12ba);
            }
            return null;
          }),
          trackColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return null;
            }
            if (states.contains(WidgetState.selected)) {
              return Colors.black;
            }
            return null;
          }),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xffffffff)),
        colorScheme: ColorScheme.fromSwatch(
            brightness: Brightness.light,
            primarySwatch: const MaterialColor(4288120051, {
              50: Color(0xffebe8fd),
              100: Color(0xffd8d1fa),
              200: Color(0xffb0a2f6),
              300: Color(0xff8974f1),
              400: Color(0xff6245ed),
              500: Color(0xff3b17e8),
              600: Color(0xff2f12ba),
              700: Color(0xff230e8b),
              800: Color(0xff17095d),
              900: Color(0xff0c052e)
            })).copyWith(error: const Color(0xffd32f2f)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        )),
      );
}
