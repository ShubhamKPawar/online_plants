import 'package:get_it/get_it.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/locale/locale_manager.dart';
import 'package:online_plants_app/core/services_data/data/datasource/seller_datasource.dart';
import 'package:online_plants_app/core/services_data/data/datasource/seller_datasource_impl.dart';
import 'package:online_plants_app/core/services_data/data/datasource/user_datasource.dart';
import 'package:online_plants_app/core/services_data/data/datasource/user_datasource_impl.dart';
import 'package:online_plants_app/core/services_data/data/repository/seller_service_impl.dart';
import 'package:online_plants_app/core/services_data/data/repository/user_service_impl.dart';
import 'package:online_plants_app/core/services_data/domain/service_repository/seller_service_repo.dart';
import 'package:online_plants_app/core/services_data/domain/service_repository/user_service_repo.dart';
import 'package:online_plants_app/core/services_data/domain/usecases/seller_usecase.dart';
import 'package:online_plants_app/core/services_data/domain/usecases/user_usecase.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_bloc.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_bloc.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_manager.dart';
import 'package:online_plants_app/core/theme/bloc/theme_manager.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/home/presentation/bloc/product_image_bloc.dart';
import 'package:online_plants_app/features/login/data/datasource/login_datasource.dart';
import 'package:online_plants_app/features/login/data/datasource/login_datasource_impl.dart';
import 'package:online_plants_app/features/login/data/repository/login_service_impl.dart';
import 'package:online_plants_app/features/login/domain/service_repository/login_service_repo.dart';
import 'package:online_plants_app/features/login/domain/usecase/login_usecase.dart';
import 'package:online_plants_app/features/login/presentation/bloc/login_cubit.dart';

final dependencyLocator = GetIt.instance;
Future<void> setupDependencyLocator() async {
  // Registering BottomNavigationBloc
  dependencyLocator.registerLazySingleton<BottomNavigationBloc>(
      () => BottomNavigationBloc());

  HivePref hivePref = await HivePref.getInstance();

  //Registering LocaleManager
  dependencyLocator
      .registerLazySingleton<LocaleManager>(() => LocaleManager(hivePref));
  // Registering ThemeManager
  dependencyLocator
      .registerLazySingleton<ThemeManager>(() => ThemeManager(hivePref));
  dependencyLocator
      .registerLazySingleton<UserInfoManager>(() => UserInfoManager(hivePref));

  // Registering CartBloc
  dependencyLocator.registerFactory<CartBloc>(() => CartBloc());

  //Registering CartStreamBloc
  dependencyLocator.registerLazySingleton<CartCubit>(() => CartCubit());

  dependencyLocator.registerLazySingleton<LoginCubit>(() => LoginCubit());

  dependencyLocator
      .registerFactory<ProductImageBloc>(() => ProductImageBloc(hivePref));

  _userInfo(hivePref);
  _sellerInfo(hivePref);
}

_sellerInfo(HivePref hivePref) {
  dependencyLocator.registerSingleton<SellerDatasource>(
      SellerDatasourceImpl(hivePref: hivePref));

  dependencyLocator.registerSingleton<SellerServiceRepo>(
      SellerServiceImpl(dependencyLocator()));

  dependencyLocator.registerSingleton<GetSellerUsecase>(
      GetSellerUsecase(dependencyLocator()));

  dependencyLocator.registerSingleton<AddUpdateSellerUsecase>(
      AddUpdateSellerUsecase(dependencyLocator()));

  // Registering LoginBloc
  dependencyLocator.registerFactory<SellerInfoBloc>(
    () => SellerInfoBloc(
      getSellerUsecase: dependencyLocator(),
      addUpdateSellerUsecase: dependencyLocator(),
    ),
  );
}

_userInfo(HivePref hivePref) {
  dependencyLocator.registerSingleton<UserDatasource>(
      UserDatasourceImpl(hivePref: hivePref));

  dependencyLocator
      .registerSingleton<UserServiceRepo>(UserServiceImpl(dependencyLocator()));

  dependencyLocator
      .registerSingleton<GetUserUsecase>(GetUserUsecase(dependencyLocator()));

  dependencyLocator.registerSingleton<AddUpdateUserUsecase>(
      AddUpdateUserUsecase(dependencyLocator()));

  dependencyLocator.registerSingleton<ChangeUserPasswordUseCase>(
      ChangeUserPasswordUseCase(dependencyLocator()));

  dependencyLocator.registerSingleton<LoginDatasource>(
      LoginDatasourceImpl(hivePref: hivePref));

  dependencyLocator.registerSingleton<LoginRepository>(
      LoginServiceImpl(dependencyLocator()));

  dependencyLocator.registerSingleton<LoginImageUseCase>(
      LoginImageUseCase(dependencyLocator()));

  dependencyLocator
      .registerSingleton<LoginUseCase>(LoginUseCase(dependencyLocator()));

  dependencyLocator
      .registerSingleton<RegisterUseCase>(RegisterUseCase(dependencyLocator()));

  dependencyLocator.registerSingleton<GoogleLoginUseCase>(
      GoogleLoginUseCase(dependencyLocator()));

  dependencyLocator.registerSingleton<AppleLoginUseCase>(
      AppleLoginUseCase(dependencyLocator()));

  // Registering LoginBloc
  dependencyLocator.registerFactory<UserInfoBloc>(
    () => UserInfoBloc(
      getUserUsecase: dependencyLocator(),
      addUpdateUserUsecase: dependencyLocator(),
      hivepref: hivePref,
      changePasswordUsecase: dependencyLocator(),
      imageUseCase: dependencyLocator(),
      loginUseCase: dependencyLocator(),
      registerUseCase: dependencyLocator(),
      googleLoginUseCase: dependencyLocator(),
      appleLoginUseCase: dependencyLocator(),
    ),
  );
}
