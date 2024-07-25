// Define the theme states
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_enum.dart';

abstract class ThemeState extends Equatable {
  final ThemeData themeData;
  final ThemeEnum themeEnum;

  const ThemeState(this.themeData, this.themeEnum);

  @override
  List<Object> get props => [themeData, themeEnum];
}

class ThemeInitial extends ThemeState {
  ThemeInitial() : super(ThemeEnum.DARK.generateTheme, ThemeEnum.DARK);
}

class ThemeUpdated extends ThemeState {
  const ThemeUpdated(super.themeData, super.themeEnum);
}
