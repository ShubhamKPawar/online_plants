import 'dart:math';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class PlantsListing extends StatefulWidget {
  final int index;
  final String title;
  const PlantsListing({super.key, required this.index, required this.title});

  @override
  State<PlantsListing> createState() => _PlantsListingState();
}

class _PlantsListingState extends State<PlantsListing> {
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
                    if (widget.title != 'Goreshwar Special') ...[
                      const Icon(Icons.grid_view_rounded),
                      SizedBox(
                        width: getWidth(5),
                      ),
                    ],
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.loginRoute);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: getWidth(1)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View all',
                          textAlign: TextAlign.center,
                          style:
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
        if (widget.title != 'Goreshwar Special')
          SizedBox(
            height: getHeight(190),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10, // Example item count
              itemBuilder: (context, index) {
                double opacity =
                    0.1 * (index % 10); // Calculate opacity dynamically
                Color greenColor = AppColor.skGreen.withOpacity(opacity);
                int randomIndex = Random().nextInt(imageList.length);
                String plant = imageList[randomIndex];
                return Padding(
                  padding: EdgeInsets.all(getHeight(4.5)),
                  child: Card(
                    color: greenColor,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(getHeight(15)),
                    ),
                    child: Stack(children: [
                      SizedBox(
                        height: getHeight(180),
                        width: getWidth(130),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: getWidth(3),
                                right: getWidth(3),
                                top: getHeight(8),
                                bottom: getHeight(2.5),
                              ),
                              child: Container(
                                height: getHeight(100),
                                width: getWidth(100),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(getHeight(12)),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              AppColor.skBlack.withOpacity(0.6),
                                          offset:
                                              Offset(getHeight(3), getWidth(3)),
                                          blurRadius: 0.8,
                                          spreadRadius: 0.4)
                                    ]),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(getHeight(12)),
                                  child: Image(
                                    image: AssetImage(plant),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(getHeight(2)),
                              child: Card(
                                color: AppColor.skWhite,
                                elevation: 2,
                                shadowColor: AppColor.skGrey,
                                surfaceTintColor: AppColor.skBlack,
                                child: Padding(
                                  padding: EdgeInsets.all(getHeight(5)),
                                  child: SizedBox(
                                    width: getWidth(100),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getHeight(5)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Marigold",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                    text: '\u{20B9} ',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    children: [
                                                      TextSpan(
                                                        text: '20/-',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ]),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Container(
                                              height: getHeight(25),
                                              width: getHeight(25),
                                              decoration: BoxDecoration(
                                                  color: AppColor.skBlack,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Icon(
                                                Icons.add,
                                                size: getHeight(14),
                                                color: AppColor.skWhite,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            height: getHeight(25),
                            width: getHeight(25),
                            decoration: BoxDecoration(
                                color: AppColor.skWhite,
                                borderRadius: BorderRadius.circular(8)),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.black,
                                size: getHeight(20),
                              ),
                            ),
                          ))
                    ]),
                  ),
                );
              },
            ),
          )
        else
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                double opacity =
                    0.1 * (index % 4); // Calculate opacity dynamically
                // ignore: unused_local_variable
                Color greenColor = AppColor.skGreen.withOpacity(opacity);
                int randomIndex = Random().nextInt(imageList.length);
                String plant = imageList[randomIndex];

                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(20.0), vertical: getHeight(5)),
                  child: Card(
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
                              width: getWidth(90),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(getHeight(12)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            AppColor.skBlack.withOpacity(0.6),
                                        offset: const Offset(3, 3),
                                        blurRadius: 0.8,
                                        spreadRadius: 0.4)
                                  ]),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(getHeight(12)),
                                child: Image(
                                  image: AssetImage(plant),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getHeight(10),
                              horizontal: getWidth(20),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Marigold",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '120 ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: 'plants/lot',
                                        style: TextStyle(
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
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      children: [
                                        TextSpan(
                                          text: '20/-',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
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
                                  child: Container(
                                    height: getHeight(25),
                                    width: getHeight(25),
                                    decoration: BoxDecoration(
                                        color: AppColor.skWhite,
                                        borderRadius: BorderRadius.circular(
                                            getHeight(8))),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.black,
                                        size: getHeight(20),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: getWidth(65),
                                  height: getHeight(35),
                                  decoration: BoxDecoration(
                                    color: AppColor.skGreenColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(getHeight(18)),
                                      topLeft: Radius.circular(getHeight(15)),
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: getHeight(25),
                                      color: AppColor.skWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
      ],
    );
  }
}
