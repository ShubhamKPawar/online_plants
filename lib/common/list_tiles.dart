import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    super.key,
    required this.text,
    required this.svgSrc,
    required this.press,
    this.isShowDivider = true,
  });

  final String text, svgSrc;
  final VoidCallback press;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        minLeadingWidth: getWidth(24),
        leading: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: AppColor.skWhite,
            image: DecorationImage(
              image: AssetImage(
                svgSrc,
              ),
            ),
          ),
        ),
        onTap: press,
        title: Text(
          text,
          style:
              Theme.of(context).textTheme.bodyMedium ?? TextStyle(fontSize: 14),
        ),
        trailing: Image.asset(
          AppImages.miniRightSvg,
        ),
      ),
      if (isShowDivider) const Divider(height: Dimens.skDividerHeight),
    ]);
  }
}

class MenuItemListTile extends StatelessWidget {
  final String text;
  final Widget trailing;
  final VoidCallback onTap;
  final Widget leading;
  const MenuItemListTile({
    super.key,
    required this.text,
    required this.trailing,
    required this.onTap,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: getWidth(24),
      leading: leading,
      onTap: onTap,
      title: Text(
        text,
        style:
            Theme.of(context).textTheme.bodyMedium ?? TextStyle(fontSize: 14),
      ),
      trailing: trailing,
    );
  }
}
