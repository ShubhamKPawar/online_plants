import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class RoundGridView extends StatelessWidget {
  final VoidCallback onTap;
  const RoundGridView({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(getHeight(5)),
              bottomRight: Radius.circular(getHeight(5)))),
      child: GestureDetector(
        child: Icon(
          Icons.grid_view_rounded,
          color: AppColor.skGreen,
          size: getHeight(30),
        ),
        onTap: () {},
      ),
    );
  }
}
