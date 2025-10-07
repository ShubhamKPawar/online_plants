import 'package:flutter/material.dart';
import 'package:online_plants_app/common/add_product.dart';
import 'package:online_plants_app/common/like_product.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/theme/theme_data/app_text_styles.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class MyCartItems extends StatefulWidget {
  final int index;
  const MyCartItems({super.key, required this.index});

  @override
  State<MyCartItems> createState() => _MyCartItemsState();
}

class _MyCartItemsState extends State<MyCartItems> {
  @override
  Widget build(BuildContext context) {
    double opacity = 0.1 * (widget.index % 4);
    Color greenColor = AppColor.skGreen.withOpacity(opacity);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getHeight(25),
        horizontal: getWidth(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            color: greenColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getHeight(15)),
            ),
            child: SizedBox(
              height: getHeight(100),
              child: Padding(
                padding: EdgeInsets.only(
                  left: getWidth(140),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getHeight(10),
                        horizontal: getWidth(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Marigold",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium ??
                                TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '120 ',
                                  style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontFamily: AppTextStyles
                                                  .numberFontFamily) ??
                                      TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                ),
                                TextSpan(
                                  text: 'plants/lot',
                                  style:
                                      Theme.of(context).textTheme.labelSmall ??
                                          TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                                text: '\u{20B9} ',
                                style: Theme.of(context).textTheme.labelLarge ??
                                    TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                    text: '20/-',
                                    style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontFamily: AppTextStyles
                                                    .numberFontFamily) ??
                                        TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                  )
                                ]),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: getWidth(55),
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            AddProduct(
                              addType: AddType.vertical,
                              height: 30,
                              width: 55,
                              add: false,
                              icon: Icon(
                                Icons.remove,
                                size: getHeight(25),
                                color: AppColor.skWhite,
                              ),
                              callback: () {},
                            ),
                            Text(
                              '2',
                              style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                          fontFamily:
                                              AppTextStyles.numberFontFamily) ??
                                  TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            AddProduct(
                              addType: AddType.vertical,
                              height: 30,
                              width: 60,
                              callback: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: getWidth(10),
            bottom: getHeight(10),
            child: Card(
              color: greenColor,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(getHeight(20)),
              ),
              child: Stack(
                children: [
                  Container(
                    height: getHeight(120),
                    width: getWidth(130),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(getHeight(15)),
                        boxShadow: [
                          BoxShadow(
                              color: AppColor.skBlack.withOpacity(0.5),
                              offset: Offset(getHeight(2), getWidth(2)),
                              blurRadius: 0.3,
                              spreadRadius: 0.2)
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(getHeight(15)),
                      child: const Image(
                        image: AssetImage(AppImages.kTomato),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: getWidth(4),
                    top: getHeight(4),
                    child: LikeProduct(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
