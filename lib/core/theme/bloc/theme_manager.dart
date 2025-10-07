import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';

import 'adaptive_theme_state.dart';

class ThemeManager extends Cubit<AdaptiveThemeState> {
  final HivePref hivePref;

  ThemeManager(this.hivePref)
      : super(hivePref.getThemeMode()
            ? AdaptiveThemeState.dark
            : AdaptiveThemeState.light);

  bool isDarkTheme = false;

  setLightTheme() {
    hivePref.setDarkMode(false);
    isDarkTheme = false;
    emit(AdaptiveThemeState.light);
  }

  setDarkTheme() {
    hivePref.setDarkMode(true);
    isDarkTheme = true;
    emit(AdaptiveThemeState.dark);
  }

  void getTheme() {
    isDarkTheme = hivePref.getThemeMode();
    if (isDarkTheme) {
      emit(AdaptiveThemeState.dark);
    } else {
      emit(AdaptiveThemeState.light);
    }
  }
}
