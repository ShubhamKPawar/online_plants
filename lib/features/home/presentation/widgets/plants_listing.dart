import 'dart:math';

import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/utils/app_color.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.grid_view_rounded),
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: fontFamilyCustom,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'see all',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColor.skGrey),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10, // Example item count
            itemBuilder: (context, index) {
              double opacity =
                  0.1 * (index + 1); // Calculate opacity dynamically
              Color greenColor = AppColor.skGreen.withOpacity(opacity);
              int randomIndex = Random().nextInt(imageList.length);
              String plant = imageList[randomIndex];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: greenColor,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(children: [
                    SizedBox(
                      height: 240,
                      width: 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0, bottom: 2.0),
                            child: SizedBox(
                                height: 140,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: AssetImage(plant),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              color: AppColor.skWhite,
                              elevation: 2,
                              shadowColor: AppColor.skGrey,
                              surfaceTintColor: AppColor.skBlack,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: SizedBox(
                                  width: 120,
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
                                          Text("Plant Name"),
                                          Text('Price: 20/-')
                                        ],
                                      ),
                                      Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: AppColor.skBlack,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Icon(
                                            Icons.add,
                                            color: AppColor.skWhite,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: AppColor.skWhite,
                              borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                              onPressed: () {},
                              iconSize: 20,
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                              )),
                        ))
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
