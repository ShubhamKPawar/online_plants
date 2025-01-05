import 'package:get_it/get_it.dart';
import 'package:online_plants_app/core/theme/bloc/theme_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/login/data/datasource/login_datasource.dart';
import 'package:online_plants_app/features/login/data/datasource/login_datasource_impl.dart';
import 'package:online_plants_app/features/login/data/repository/login_service_impl.dart';
import 'package:online_plants_app/features/login/domain/service_repository/login_service_repo.dart';
import 'package:online_plants_app/features/login/domain/usecase/login_usecase.dart';
import 'package:online_plants_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/login_cubit.dart';

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

  dependencyLocator
      .registerFactory<LoginUseCase>(() => LoginUseCase(dependencyLocator()));

  dependencyLocator.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(dependencyLocator()));

  dependencyLocator.registerFactory<GoogleLoginUseCase>(
      () => GoogleLoginUseCase(dependencyLocator()));

  dependencyLocator.registerFactory<AppleLoginUseCase>(
      () => AppleLoginUseCase(dependencyLocator()));

  // Registering LoginBloc
  dependencyLocator.registerLazySingleton<LoginBloc>(
    () => LoginBloc(
      imageUseCase: dependencyLocator(),
      loginUseCase: dependencyLocator(),
      registerUseCase: dependencyLocator(),
      googleLoginUseCase: dependencyLocator(),
      appleLoginUseCase: dependencyLocator(),
    ),
  );

  //Registering LoginStreamBloc
  dependencyLocator.registerLazySingleton<LoginCubit>(() => LoginCubit());
}
