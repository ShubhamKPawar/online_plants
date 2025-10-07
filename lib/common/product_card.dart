import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:online_plants_app/common/add_product.dart';
import 'package:online_plants_app/common/like_product.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/theme/theme_data/app_text_styles.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class ProductCard extends StatefulWidget {
  final int index;
  final bool fromWishlist;
  const ProductCard(
      {super.key, required this.index, required this.fromWishlist});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<String> imageList = <String>[
    AppImages.kBrinjal,
    AppImages.kChilli,
    AppImages.kMarigold,
    AppImages.kTomato
  ];

  @override
  Widget build(BuildContext context) {
    double opacity = 0.1 * (widget.index % 4); // Calculate opacity dynamically
    // ignore: unused_local_variable
    Color greenColor = AppColor.skGreen.withOpacity(opacity);
    int randomIndex = math.Random().nextInt(imageList.length);
    String plant = imageList[randomIndex];
    return Card(
      color: greenColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getHeight(15)),
      ),
      child: SizedBox(
        height: getHeight(190),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(getHeight(8.0)).copyWith(bottom: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(getHeight(15)),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.skBlack.withOpacity(0.5),
                            offset: Offset(getHeight(2), getWidth(2)),
                            blurRadius: 0.3,
                            spreadRadius: 0.2)
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(getHeight(15)),
                      clipBehavior: Clip.hardEdge,
                      child: Image(
                        height: getHeight(130),
                        width: double.infinity,
                        image: AssetImage(plant),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(2.0)),
                  child: Container(
                    padding: EdgeInsets.all(getHeight(5))
                        .copyWith(left: getWidth(8.0), right: getWidth(8.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: getWidth(8.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Marigold",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall ??
                                    TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                              ),
                              Text.rich(
                                TextSpan(
                                    text: '\u{20B9} ',
                                    style: Theme.of(context)
                                            .textTheme
                                            .labelLarge ??
                                        TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                    children: [
                                      TextSpan(
                                        text: '20/-',
                                        style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                    fontFamily: AppTextStyles
                                                        .numberFontFamily) ??
                                            TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                      )
                                    ]),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: getWidth(4.0),
                        ),
                        AddProduct(
                          addType: AddType.horizontal,
                          callback: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (!widget.fromWishlist)
              Positioned(
                right: getHeight(8.0),
                top: getHeight(8.0),
                child: LikeProduct(),
              ),
          ],
        ),
      ),
    );
  }
}
