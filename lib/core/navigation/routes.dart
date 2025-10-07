// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/admin/admin_dashboard.dart';
import 'package:online_plants_app/admin/features/manage_plants.dart';
import 'package:online_plants_app/admin/features/admin_profile.dart';
import 'package:online_plants_app/admin/features/category_page.dart';
import 'package:online_plants_app/core/navigation/custom_navigation.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/pages/dashboard.dart';
import 'package:online_plants_app/features/cart/presentation/pages/cart.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/pages/splash.dart';
import 'package:online_plants_app/features/home/presentation/pages/home.dart';
import 'package:online_plants_app/features/home/presentation/pages/more_products.dart';
import 'package:online_plants_app/features/login/presentation/pages/login_page.dart';
import 'package:online_plants_app/features/profile/presentation/pages/addresses.dart';
import 'package:online_plants_app/features/profile/presentation/pages/my_orders.dart';
import 'package:online_plants_app/features/profile/presentation/pages/notifications.dart';
import 'package:online_plants_app/features/profile/presentation/pages/profile.dart';
import 'package:online_plants_app/features/profile/presentation/pages/track_order.dart';
import 'package:online_plants_app/features/profile/presentation/pages/user_profile.dart';
import 'package:online_plants_app/features/profile/presentation/pages/wishlist.dart';
import 'package:online_plants_app/features/search/presentation/pages/search.dart';
import 'package:online_plants_app/features/timeline/presentation/pages/lateset_timeline.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String dashboardRoute = '/dashboard';
  static const String homeRoute = '/home';
  static const String cartRoute = '/cart';
  static const String searchRoute = '/search';
  static const String latestTimelineRoute = '/latestTimeline';
  static const String profileRoute = '/profile';
  static const String loginRoute = '/login';
  static const String moreProducts = '/moreProducts:id:title';
  static const String userProfile = '/userProfile';
  static const String userAddresses = '/userAddresses';
  static const String userNotifications = '/userNotifications';
  static const String wishlistProducts = '/wishlist';
  static const String myOrders = '/myOrders';
  static const String trackOrder = '/trackOrder';

  //ADMIN
  static const String adminDashboard = '/adminDashboard';
  static const String adminAddCategory = '/adminAddCategory';
  static const String adminAddPlant = '/adminAddPlant';

  static const String adminProfile = '/adminProfile';

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
      case moreProducts:
        final args = settings.arguments as Map<String, String>;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          child: MoreProducts(
            title: args['title'] ?? '',
            id: args['id'] ?? '',
          ),
        );
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
      case latestTimelineRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const LatestTimeline());
      case profileRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const Profile());
      case userProfile:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const UserProfile());
      case userAddresses:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          child: Addresses(),
        );
      case userNotifications:
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          child: Notifications(),
        );
      case wishlistProducts:
        return PageTransition(
            child: WishlistProducts(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 100));
      case myOrders:
        return PageTransition(
            child: MyOrders(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 100));

      case trackOrder:
        final args = settings.arguments as Map<String, String>;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          child: TrackOrder(
            id: args['id'] ?? '',
          ),
        );
      case loginRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const LoginPage());
      //*******************Admin*************************//
      case adminDashboard:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const AdminDashboard());
      case adminAddCategory:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const AddCategoryPage());
      case adminAddPlant:
        return PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: const ManagePlantsPage());

      case adminProfile:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 100),
          child: AdminProfile(
            fromAdmin: args['fromAdmin'] ?? false,
            sellerModel:
                args['seller'] == null ? null : args['seller'] as SellerModel,
          ),
        );

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
