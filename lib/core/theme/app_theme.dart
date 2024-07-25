import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/theme/bloc/theme_bloc.dart';

abstract class ApplicationTheme {
  ThemeData? theme;
}

// Extension on BuildContext to access the current theme
extension ThemeContextExtension on BuildContext {
  ThemeData get theme => watch<ThemeBloc>().state.themeData;
}
