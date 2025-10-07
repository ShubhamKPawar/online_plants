import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/main.dart';

void showSnackbar(BuildContext context, String message, Color color) {
  // scaffoldMessengerKey.currentState?.showSnackBar(
  //   SnackBar(
  //     content: Text(
  //       message,
  //       textAlign: TextAlign.center,
  //       style: const TextStyle(color: Colors.white),
  //     ),
  //     backgroundColor: color,
  //     margin: EdgeInsets.only(
  //       bottom: MediaQuery.of(context).size.height - 100, // Adjust as needed
  //       left: 20,
  //       right: 20,
  //     ),
  //     behavior: SnackBarBehavior.floating,
  //     duration: const Duration(seconds: 2),
  //   ),
  // );
  print('snakbar...$message');
}

class InAppLoaderWidget extends StatelessWidget {
  final double? radius;
  final Color? color;

  const InAppLoaderWidget({super.key, this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: color,
      radius: radius ?? 15,
    );
  }
}
