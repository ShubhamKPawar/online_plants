import 'package:equatable/equatable.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_enum.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends ThemeEvent {
  final ThemeEnum themeEnum;

  const ChangeThemeEvent(this.themeEnum);

  @override
  List<Object> get props => [themeEnum];
}
