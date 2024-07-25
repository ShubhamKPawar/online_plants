// Define the ThemeBloc class

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/theme/bloc/theme_event.dart';
import 'package:online_plants_app/core/theme/bloc/theme_state.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_enum.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial());

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ChangeThemeEvent) {
      final newThemeData = event.themeEnum.generateTheme;
      yield ThemeUpdated(newThemeData, event.themeEnum);
    }
  }
}
