import 'dart:math';
import 'package:flutter/material.dart';
import 'package:online_plants_app/common/add_product.dart';
import 'package:online_plants_app/common/like_product.dart';
import 'package:online_plants_app/common/parallax_flow.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/theme/theme_data/app_text_styles.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class PlantsListingHorizontal extends StatefulWidget {
  final String id;
  final int index;
  final String title;
  final Function(GlobalKey, String, String) addToCartAnimation;
  const PlantsListingHorizontal(
      {super.key,
      required this.id,
      required this.index,
      required this.title,
      required this.addToCartAnimation});

  @override
  State<PlantsListingHorizontal> createState() =>
      _PlantsListingHorizontalState();
}

class _PlantsListingHorizontalState extends State<PlantsListingHorizontal> {
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
                    const Icon(
                      Icons.grid_view_rounded,
                      color: AppColor.skGreenColor,
                    ),
                    SizedBox(
                      width: getWidth(5),
                    ),
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
        // SizedBox(
        //   height: getHeight(220),
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 10, // Example item count
        //     itemBuilder: (context, index) {
        //       double opacity =
        //           0.1 * (index % 10); // Calculate opacity dynamically
        //       Color greenColor = AppColor.skGreen.withOpacity(opacity);
        //       int randomIndex = Random().nextInt(imageList.length);
        //       String plant = imageList[randomIndex];
        //       return _plantsCard(greenColor, plant, context);
        //     },
        //   ),
        // ),

        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: getHeight(200),
            width: double.infinity,
            child: CarouselView(
                itemSnapping: true,
                elevation: 0.0,
                enableSplash: false,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                shrinkExtent: getWidth(170),
                itemExtent: getWidth(170),
                children: [
                  ...List.generate(10, (item) {
                    int randomIndex = Random().nextInt(imageList.length);
                    String plant = imageList[randomIndex];
                    GlobalKey productKey = GlobalKey();
                    return PlantCardHorizontal(
                        plant: plant,
                        id: item.toString(),
                        index: widget.index,
                        productKey: productKey,
                        addToCartAnimation: widget.addToCartAnimation);
                  })
                ]),
          ),
        ),
      ],
    );
  }
}

class PlantCardHorizontal extends StatefulWidget {
  final String plant;
  final String id;
  final int index;
  final GlobalKey productKey;
  final Function(GlobalKey, String, String) addToCartAnimation;
  const PlantCardHorizontal(
      {super.key,
      required this.plant,
      required this.id,
      required this.index,
      required this.productKey,
      required this.addToCartAnimation});

  @override
  State<PlantCardHorizontal> createState() => _PlantCardHorizontalState();
}

class _PlantCardHorizontalState extends State<PlantCardHorizontal>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    double opacity = 0.1 * (widget.index % 4); // Calculate opacity dynamically
    Color greenColor = AppColor.skGreen.withOpacity(opacity);

    return Card(
      color: greenColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getHeight(20)),
      ),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              padding: EdgeInsets.symmetric(horizontal: getWidth(2.0)),
              child: Card(
                elevation: 2,
                shadowColor: AppColor.skGrey,
                surfaceTintColor: AppColor.skBlack,
                child: Container(
                  padding: EdgeInsets.all(getHeight(5))
                      .copyWith(left: getWidth(8.0), right: getWidth(8.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Marigold",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall ??
                                TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text.rich(
                            TextSpan(
                                text: '\u{20B9} ',
                                style: Theme.of(context).textTheme.labelSmall ??
                                    TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                children: [
                                  TextSpan(
                                    text: '20/-',
                                    style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
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
                      AddProduct(
                        addType: AddType.horizontal,
                        callback: () => widget.addToCartAnimation
                            .call(widget.productKey, widget.id, widget.plant),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          right: 8,
          top: 8,
          child: LikeProduct(),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
