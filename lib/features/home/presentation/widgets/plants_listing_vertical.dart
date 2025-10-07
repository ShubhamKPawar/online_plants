import 'dart:math';
import 'package:flutter/material.dart';
import 'package:online_plants_app/common/add_product.dart';
import 'package:online_plants_app/common/like_product.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/theme/theme_data/app_text_styles.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class PlantsListingVertical extends StatefulWidget {
  final String id;
  final int index;
  final String title;
  final Function(GlobalKey, String, String) addToCartAnimation;
  const PlantsListingVertical({
    super.key,
    required this.id,
    required this.index,
    required this.title,
    required this.addToCartAnimation,
  });

  @override
  State<PlantsListingVertical> createState() => _PlantsListingVerticalState();
}

class _PlantsListingVerticalState extends State<PlantsListingVertical> {
  List<String> imageList = <String>[
    AppImages.kBrinjal,
    AppImages.kChilli,
    AppImages.kMarigold,
    AppImages.kTomato
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getHeight(6), horizontal: getWidth(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: AppColor.skGreenColor,
                                  fontWeight: FontWeight.w700) ??
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.moreProducts,
                      arguments: {'title': widget.title, 'id': widget.id},
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: getWidth(1)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View all',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColor.skGrey) ??
                              TextStyle(fontSize: 14, color: AppColor.skGrey),
                        ),
                        Icon(Icons.navigate_next_sharp),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, item) {
              int randomIndex = Random().nextInt(imageList.length);
              String plant = imageList[randomIndex];
              GlobalKey productKey = GlobalKey();
              return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getHeight(5),
                    horizontal: getWidth(20),
                  ),
                  child: PlantCardVertical(
                    plant: plant,
                    id: item.toString(),
                    index: widget.index,
                    productKey: productKey,
                    addToCartAnimation: widget.addToCartAnimation,
                  ));
            }),
      ],
    );
  }
}

class PlantCardVertical extends StatefulWidget {
  final String plant;
  final String id;
  final int index;
  final GlobalKey productKey;
  final Function(GlobalKey, String, String) addToCartAnimation;
  const PlantCardVertical(
      {super.key,
      required this.plant,
      required this.id,
      required this.index,
      required this.productKey,
      required this.addToCartAnimation});

  @override
  State<PlantCardVertical> createState() => _PlantCardVerticalState();
}

class _PlantCardVerticalState extends State<PlantCardVertical>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double opacity = 0.1 * (widget.index % 4);
    Color greenColor = AppColor.skGreen.withOpacity(opacity);

    return Card(
      color: greenColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getHeight(15)),
      ),
      child: SizedBox(
        height: getHeight(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: getWidth(10.0),
                  right: getWidth(10.0),
                  top: getHeight(10.0),
                  bottom: getHeight(10.0)),
              child: Container(
                height: getHeight(90),
                width: getWidth(130),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight(12)),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.skBlack.withOpacity(0.5),
                          offset: Offset(getHeight(2), getWidth(2)),
                          blurRadius: 0.3,
                          spreadRadius: 0.2)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(getHeight(12)),
                  child: Hero(
                    tag: "product_${widget.index}${widget.id}_${widget.plant}",
                    child: Image(
                      key: widget.productKey,
                      height: getHeight(120),
                      width: double.infinity,
                      image: AssetImage(widget.plant),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
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
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                                      fontFamily:
                                          AppTextStyles.numberFontFamily) ??
                              TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        TextSpan(
                          text: 'plants/lot',
                          style: Theme.of(context).textTheme.labelSmall ??
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
                                fontSize: 18, fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: '20/-',
                            style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontFamily:
                                            AppTextStyles.numberFontFamily) ??
                                TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(getHeight(10)),
                    child: LikeProduct(),
                  ),
                  AddProduct(
                    addType: AddType.vertical,
                    callback: () => widget.addToCartAnimation
                        .call(widget.productKey, widget.id, widget.plant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
