// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/pages/dashboard.dart';
import 'package:online_plants_app/features/cart/presentation/pages/cart.dart';
import 'package:online_plants_app/features/home/presentation/pages/home.dart';
import 'package:online_plants_app/features/profile/presentation/pages/profile.dart';
import 'package:online_plants_app/features/search/presentation/pages/search.dart';
import 'package:online_plants_app/features/timeline/presentation/pages/timeline.dart';

class AppRoutes {
  static const String dashboardRoute = '/';
  static const String homeRoute = '/home';
  static const String cartRoute = '/cart';
  static const String searchRoute = '/search';
  static const String timelineRoute = '/timeline';
  static const String profileRoute = '/profile';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboardRoute:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case homeRoute:
        return MaterialPageRoute(builder: (context) => const Home());
      case cartRoute:
        return MaterialPageRoute(builder: (context) => const Cart());
      case searchRoute:
        return MaterialPageRoute(builder: (context) => const Search());
      case timelineRoute:
        return MaterialPageRoute(builder: (context) => const Timeline());
      case profileRoute:
        return MaterialPageRoute(builder: (context) => const Profile());
      default:
        return MaterialPageRoute(builder: (context) => const Dashboard());
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
