import 'package:flutter/material.dart';
import 'package:online_plants_app/common/parallax_flow.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'dart:math' as math;

class PlantsCarousel extends StatefulWidget {
  const PlantsCarousel({super.key});

  @override
  State<PlantsCarousel> createState() => _PlantsCarouselState();
}

class _PlantsCarouselState extends State<PlantsCarousel> {
  List<String> imageList = <String>[
    AppImages.kBrinjal,
    AppImages.kChilli,
    AppImages.kMarigold,
    AppImages.kTomato
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: getHeight(180),
          child: CarouselView(
              itemSnapping: true,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              shrinkExtent: getWidth(440 / 2),
              itemExtent: getWidth(440 / 2),
              children: [
                ...List.generate(
                  4,
                  (index) {
                    return Image(
                      image: AssetImage(imageList[index]),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
