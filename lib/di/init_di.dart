import 'package:get_it/get_it.dart';
import 'package:online_plants_app/core/theme/bloc/theme_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';

final dependencyLocator = GetIt.instance;
void setupDependencyLocator() {
  // Registering BottomNavigationBloc
  dependencyLocator.registerLazySingleton<BottomNavigationBloc>(
      () => BottomNavigationBloc());

  // Registering ThemeBloc
  dependencyLocator.registerLazySingleton<ThemeBloc>(() => ThemeBloc());

  // Registering CartBloc
  dependencyLocator.registerLazySingleton<CartBloc>(() => CartBloc());

  //Registering CartStreamBloc
  dependencyLocator.registerLazySingleton<CartCubit>(() => CartCubit());
}
