import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class AddProduct extends StatelessWidget {
  final AddType addType;
  final double? height;
  final double? width;
  final Widget? icon;
  final bool add;
  final VoidCallback callback;
  const AddProduct(
      {super.key,
      required this.addType,
      required this.callback,
      this.height,
      this.width,
      this.icon,
      this.add = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback.call();
      },
      child: addType == AddType.horizontal
          ? Container(
              height: getHeight(28),
              width: getHeight(28),
              decoration: BoxDecoration(
                  color: AppColor.skGreenColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.add,
                size: getHeight(18),
                color: AppColor.skWhite,
              ))
          : Container(
              width: getWidth(width ?? 65),
              height: getHeight(height ?? 35),
              decoration: BoxDecoration(
                color: AppColor.skGreenColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(add ? getHeight(18) : 0),
                  topLeft: Radius.circular(add ? getHeight(15) : 0),
                  bottomLeft: Radius.circular(add ? 0 : getHeight(18)),
                  topRight: Radius.circular(add ? 0 : getHeight(15)),
                ),
              ),
              child: Center(
                child: icon ??
                    Icon(
                      Icons.add,
                      size: getHeight(25),
                      color: AppColor.skWhite,
                    ),
              ),
            ),
    );
  }
}

enum AddType {
  horizontal,
  vertical;
}
