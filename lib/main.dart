import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
//import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/theme/bloc/theme_bloc.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_dark.dart';
import 'package:online_plants_app/core/theme/theme_data/theme_light.dart';
import 'package:online_plants_app/di/init_di.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/pages/dashboard.dart';
import 'package:online_plants_app/features/cart/presentation/pages/cart.dart';
import 'package:online_plants_app/features/home/presentation/pages/home.dart';
import 'package:online_plants_app/features/profile/presentation/pages/profile.dart';
import 'package:online_plants_app/features/search/presentation/pages/search.dart';
import 'package:online_plants_app/features/timeline/presentation/pages/timeline.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupDependencyLocator();
  runApp(const MyApp());
}

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
            create: (BuildContext context) => dependencyLocator<ThemeBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<CartBloc>()),
        BlocProvider(
            create: (BuildContext context) => dependencyLocator<CartCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goreshwar Hi-Tech Nursery',
        navigatorKey: NavigationService.navigationKey,
        // onGenerateRoute: AppRoutes.generateRoute,
        // initialRoute: AppRoutes.dashboardRoute,
        theme: isDark ? ThemeDark.instance.theme : ThemeLight.instance.theme,
        initialRoute: AppRoutes.dashboardRoute,
        routes: {
          AppRoutes.dashboardRoute: (context) => const Dashboard(),
          AppRoutes.homeRoute: (context) => const Home(),
          AppRoutes.cartRoute: (context) => const Cart(),
          AppRoutes.searchRoute: (context) => const Search(),
          AppRoutes.timelineRoute: (context) => const Timeline(),
          AppRoutes.profileRoute: (context) => const Profile(),
        },
      ),
    );
  }
}
