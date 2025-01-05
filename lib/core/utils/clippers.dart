import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/size.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - getHeight(45.01));
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(
        size.width - (size.width / 3.24), size.height - getHeight(94.523539));
    var secondEnd = Offset(size.width, size.height - getHeight(9.0022));
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

// Start at the top-left corner
    path.moveTo(0, getHeight(72.27));

// First wave curves downward
    var firstStart = Offset(
        size.width / 5, getHeight(70.664)); // Adjusted control point below
    var firstEnd =
        Offset(size.width / 2.25, getHeight(27.302)); // End point at the top
    path.quadraticBezierTo(
      firstStart.dx,
      firstStart.dy,
      firstEnd.dx,
      firstEnd.dy,
    );

// Second wave curves upward
    var secondStart =
        Offset(size.width - (size.width / 3.34), -getHeight(21.681));
    var secondEnd = Offset(size.width, getHeight(62.634));
    path.quadraticBezierTo(
      secondStart.dx,
      secondStart.dy,
      secondEnd.dx,
      secondEnd.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
