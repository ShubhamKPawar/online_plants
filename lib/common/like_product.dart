import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class LikeProduct extends StatefulWidget {
  const LikeProduct({super.key});

  @override
  State<LikeProduct> createState() => _LikeProductState();
}

class _LikeProductState extends State<LikeProduct> {
  bool isLiked = false;
  bool isGlowing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
          setState(() {
            isGlowing = true;
          });
        }

        Future.delayed(Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              isLiked = !isLiked;
              isGlowing = false;
            });
          }
        });
      },
      child: Container(
        height: getHeight(28),
        width: getHeight(28),
        decoration: BoxDecoration(
            color: AppColor.skWhite, borderRadius: BorderRadius.circular(8)),
        child: AvatarGlow(
          repeat: false,
          glowColor: isGlowing ? AppColor.skRed : AppColor.skWhite,
          glowShape: BoxShape.circle,
          animate: isGlowing,
          curve: Curves.fastOutSlowIn,
          glowRadiusFactor: 0.5,
          duration: Duration(milliseconds: 200),
          glowCount: 1,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked
                ? AppColor.skRed
                : AppColor.skBlack, // Icon color stays as per the isLiked state
            size: getHeight(23),
          ),
        ),
      ),
    );
  }
}
