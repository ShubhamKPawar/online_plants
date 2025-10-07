import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class CustomTile extends StatelessWidget {
  final String text;
  const CustomTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return text.isEmpty
        ? const SizedBox.shrink()
        : Center(
            child: Container(
              padding: EdgeInsets.all(getHeight(5)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: AppColor.skGreenColor) ??
                      TextStyle(
                          fontSize: 25,
                          // color: Colors.black,
                          fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
  }
}
