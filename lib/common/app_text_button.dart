import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: AppColor.skWhite),
      ),
    );
  }
}
