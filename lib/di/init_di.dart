import 'package:get_it/get_it.dart';
import 'package:online_plants_app/core/theme/bloc/theme_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/login/data/datasource/Login_datasource.dart';
import 'package:online_plants_app/features/login/data/datasource/Login_datasource_impl.dart';
import 'package:online_plants_app/features/login/data/repository/Login_service_impl.dart';
import 'package:online_plants_app/features/login/domain/service_repository/Login_service_repo.dart';
import 'package:online_plants_app/features/login/domain/usecase/Login_image_usecase.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_cubit.dart';

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
  _loginImp();
}

_loginImp() {
  dependencyLocator
      .registerFactory<LoginDatasource>(() => LoginDatasourceImpl());

  dependencyLocator.registerFactory<LoginRepository>(
      () => LoginServiceImpl(dependencyLocator()));

  dependencyLocator.registerFactory<LoginImageUseCase>(
      () => LoginImageUseCase(dependencyLocator()));
  // Registering LoginBloc
  dependencyLocator.registerLazySingleton<LoginBloc>(
      () => LoginBloc(imageUseCase: dependencyLocator()));

  //Registering LoginStreamBloc
  dependencyLocator.registerLazySingleton<LoginCubit>(() => LoginCubit());
}
