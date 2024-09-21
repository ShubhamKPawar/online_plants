import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Trigger fade-in after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    // Trigger fade-out after 1.5 seconds
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _opacity = 0.0;
        });
      }
    });

    // Navigate to Dashboard after 3 seconds
    Timer(const Duration(seconds: 3), () {
      print("FIREBASE: ${FirebaseAuth.instance.currentUser}");
      print("HIVE: ${hiveInstance?.getIsLogging()}");
      print(
          '${(hiveInstance?.getIsLogging() ?? false) || (hiveInstance?.getIsGuest() ?? false)}');
      if ((hiveInstance?.getIsLogging() ?? false) ||
          (hiveInstance?.getIsGuest() ?? false)) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashboardRoute,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.loginRoute,
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 800),
                child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: AssetImage(AppImages.kGoreshwarLogo)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
