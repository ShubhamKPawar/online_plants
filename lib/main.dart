import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/firestore/firebase_option.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/theme/bloc/theme_bloc.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_dark.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_light.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/di/init_di.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  hiveInstance = await HivePreference.getInstance();
  await initApp();

  setupDependencyLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WIDTH = MediaQuery.of(context).size.width;
    HEIGHT = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                dependencyLocator<BottomNavigationBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<ThemeBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<CartBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<CartCubit>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<LoginBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<LoginCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goreshwar Hi-Tech Nursery',
        navigatorKey: NavigationService.navigationKey,
        // onGenerateRoute: AppRoutes.generateRoute,
        // initialRoute: AppRoutes.dashboardRoute,
        theme: isDark
            ? ThemeDark.instance.theme!.copyWith(
                scaffoldBackgroundColor: AppColor.skWhite,
              )
            : ThemeLight.instance.theme!.copyWith(
                scaffoldBackgroundColor: AppColor.skWhite,
              ),
        initialRoute: AppRoutes.splashRoute,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}

Future<void> initApp() async {
  try {
    //if (Firebase.apps.isEmpty) {
    if (kDebugMode) {
      print("Init Firebase ${DefaultFirebaseOptions.currentPlatform}");
    }
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    //}
  } catch (e) {
    if (kDebugMode) {
      print("firebase exception: $e");
    }
  }

  // Set up Firebase Crashlytics
  try {
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // Set up Firebase performance
    FirebasePerformance performance = FirebasePerformance.instance;
    await performance
        .setPerformanceCollectionEnabled(kDebugMode ? false : true);
  } catch (e) {
    if (kDebugMode) {
      print("crash-analy error $e");
    }
  }
}
