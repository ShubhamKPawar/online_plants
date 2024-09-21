// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/navigation/custom_navigation.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/pages/dashboard.dart';
import 'package:online_plants_app/features/cart/presentation/pages/cart.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/pages/splash.dart';
import 'package:online_plants_app/features/home/presentation/pages/home.dart';
import 'package:online_plants_app/features/login/presentation/pages/login_page.dart';
import 'package:online_plants_app/features/profile/presentation/pages/profile.dart';
import 'package:online_plants_app/features/search/presentation/pages/search.dart';
import 'package:online_plants_app/features/timeline/presentation/pages/timeline.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String dashboardRoute = '/dashboard';
  static const String homeRoute = '/home';
  static const String cartRoute = '/cart';
  static const String searchRoute = '/search';
  static const String timelineRoute = '/timeline';
  static const String profileRoute = '/profile';
  static const String loginRoute = '/login';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          child: const SplashScreen(),
        );
      case dashboardRoute:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          child: const Dashboard(),
        );
      case homeRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const Home());
      case cartRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const Cart());
      case searchRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const Search());
      case timelineRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const Timeline());
      case profileRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const Profile());
      case loginRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const LoginPage());
      default:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const Dashboard());
    }
  }
}


// class AppRoutes {
//   static const String splashScreenRoute = "splashScreen";
//   static const String signinRoute = "signin";
//   static const String signupRoute = "signup";
//   static const String forgotPasswordRoute = "forgot_password";
//   static const String dashboardRoute = "dashboard";
//   static const String webViewRoute = "webview";

//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case splashScreenRoute:
//         return PageTransition(
//           type: PageTransitionType.fade,
//           duration: const Duration(milliseconds: 100),
//           child: const SplashScreen(),
//         );
//       case signinRoute:
//         return PageTransition(
//           type: PageTransitionType.fade,
//           duration: const Duration(milliseconds: 100),
//           child: const SignInScreen(),
//         );
//       case signupRoute:
//         return PageTransition(
//           type: PageTransitionType.fade,
//           duration: const Duration(milliseconds: 100),
//           child: const SignUpScreen(),
//         );
//       case forgotPasswordRoute:
//         return PageTransition(
//           type: PageTransitionType.fade,
//           duration: const Duration(milliseconds: 100),
//           child: const ForgotPasswordScreen(),
//         );
//       case dashboardRoute:
//         return PageTransition(
//           type: PageTransitionType.fade,
//           duration: const Duration(milliseconds: 100),
//           child: const DashboardScreen(),
//         );
//       case webViewRoute:
//         var url;
//         var title;
//         if (settings.arguments is Map<String, dynamic>) {
//           url = (settings.arguments as Map<String, dynamic>)["url"];
//           title = (settings.arguments as Map<String, dynamic>)["title"];
//         }
//         return PageTransition(
//           type: PageTransitionType.fade,
//           duration: const Duration(milliseconds: 100),
//           child: WebViewTermsPrivacy(title: title, url: url),
//         );

//       default:
//         return PageTransition(
//           type: PageTransitionType.rightToLeft,
//           child: Scaffold(
//             body: Center(child: Text('No route defined for ${settings.name}')),
//           ),
//         );
//     }
//   }
// }
