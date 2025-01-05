import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAssets {
  static const String doneLottie = "assets/lottie/done.json";
  static const String onWayLottie = "assets/lottie/on_way.json";
  static const String leafOneLottie = "assets/lottie/leaf_one.json";
  static const String leafTwoLottie = "assets/lottie/leaf_two.json";
  static const String loaderOneLottie = "assets/lottie/loader_one.json";
  static const String loaderTwoLottie = "assets/lottie/loader_two.json";
  static const String congratulationsLottie =
      "assets/lottie/congratulations.json";
}

class DoneAnimation extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  const DoneAnimation({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottieAssets.doneLottie,
      repeat: true,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

class OnWayAnimation extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  const OnWayAnimation({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottieAssets.onWayLottie,
      repeat: true,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

class LeafOneAnimation extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  const LeafOneAnimation({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottieAssets.leafOneLottie,
      repeat: true,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

class LeafTwoAnimation extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  const LeafTwoAnimation({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottieAssets.leafTwoLottie,
      repeat: true,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

class LoaderOneAnimation extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  const LoaderOneAnimation({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottieAssets.loaderOneLottie,
      repeat: true,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

class LoaderTwoAnimation extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  const LoaderTwoAnimation({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottieAssets.loaderTwoLottie,
      repeat: true,
      height: height,
      width: width,
      fit: fit,
    );
  }
}

class CongratulationAnimation extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit? fit;
  const CongratulationAnimation({
    super.key,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      LottieAssets.congratulationsLottie,
      repeat: true,
      height: height,
      width: width,
      fit: fit,
    );
  }
}
