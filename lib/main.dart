import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/firestore/firebase_option.dart';
import 'package:online_plants_app/core/hive_data/hive_pref.dart';
import 'package:online_plants_app/core/locale/locale_manager.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_bloc.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_bloc.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_manager.dart';
import 'package:online_plants_app/core/theme/bloc/adaptive_theme_state.dart';
import 'package:online_plants_app/core/theme/bloc/theme_manager.dart';
import 'package:online_plants_app/core/theme/theme_data/theme.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size_config.dart';
import 'package:online_plants_app/di/init_di.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/home/presentation/bloc/product_image_bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/login_cubit.dart';
import 'package:flutter_gen/gen_l10n/strings.dart';
import 'package:online_plants_app/l10n/l10n.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColor.skAppBackground1,
  ));

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  await initApp();

  await setupDependencyLocator();
  runApp(const MyApp());
}

// Future<void> getUniqueId() async {
//   try {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isIOS) {
//       var iosDeviceInfo = await deviceInfo.iosInfo;
//       Constants.appUniqueId = iosDeviceInfo.identifierForVendor ?? '';
//     } elses if (Platform.isAndroid) {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
//       Constants.appUniqueId = androidDeviceInfo.id;
//     }
//   } catch (e) {
//     Constants.appUniqueId = '';
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                dependencyLocator<BottomNavigationBloc>()),
        BlocProvider(
            create: (BuildContext context) =>
                dependencyLocator<ThemeManager>()),
        BlocProvider(
            create: (BuildContext context) =>
                dependencyLocator<LocaleManager>()),
        BlocProvider(
            create: (BuildContext context) =>
                dependencyLocator<UserInfoManager>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<CartBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<CartCubit>()),
        BlocProvider(
            create: (BuildContext context) =>
                dependencyLocator<UserInfoBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<LoginCubit>()),
        BlocProvider(
          create: (BuildContext context) => dependencyLocator<SellerInfoBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              dependencyLocator<ProductImageBloc>(),
        ),
      ],
      child: App(),
    );
  }
}

Future<void> initApp() async {
  try {
    if (kDebugMode) {
      print("Init Firebase ${DefaultFirebaseOptions.currentPlatform}");
    }
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
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

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme();
    BlocProvider.of<ThemeManager>(context).getTheme();
    BlocProvider.of<LocaleManager>(context).loadLocale();
    BlocProvider.of<UserInfoManager>(context).getUserData();

    SizeConfig.setSizeConfig(context);

    return BlocBuilder<LocaleManager, Locale>(
        buildWhen: (previous, current) =>
            previous.languageCode != current.languageCode,
        builder: (context, locale) {
          return BlocBuilder<ThemeManager, AdaptiveThemeState>(
              buildWhen: (previous, current) => previous.name != current.name,
              builder: (context, adaptiveThemeState) {
                return MaterialApp(
                  scaffoldMessengerKey: scaffoldMessengerKey,
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaler: MediaQuery.of(context)
                            .textScaler
                            .clamp(minScaleFactor: 1.0, maxScaleFactor: 1.2),
                      ),
                      child: child!,
                    );
                  },
                  debugShowCheckedModeBanner: false,
                  title: 'Goreshwar Hi-Tech Nursery',
                  navigatorKey: NavigationService.navigationKey,
                  themeMode: adaptiveThemeState == AdaptiveThemeState.light
                      ? ThemeMode.light
                      : ThemeMode.dark,
                  theme: theme.light(),
                  darkTheme: theme.dark(),
                  initialRoute: AppRoutes.splashRoute,
                  onGenerateRoute: AppRoutes.generateRoute,
                  locale: locale,
                  localizationsDelegates: Strings.localizationsDelegates,
                  supportedLocales: Strings.supportedLocales,
                );
              });
        });
  }
}
