import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/utils/app_color.dart';

class MyCartItems extends StatefulWidget {
  final int index;
  const MyCartItems({super.key, required this.index});

  @override
  State<MyCartItems> createState() => _MyCartItemsState();
}

class _MyCartItemsState extends State<MyCartItems> {
  @override
  Widget build(BuildContext context) {
    double opacity = 0.1 * (widget.index + 1);
    Color greenColor = AppColor.skGreen.withOpacity(opacity);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: greenColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(children: [
              SizedBox(
                height: 180,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: SizedBox(
                        height: 150,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Image(
                            image: AssetImage(AppImages.kTomato),
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Plant Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamilyCustom,
                          fontSize: 18,
                          color: AppColor.skBlack),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1200 ',
                            style: TextStyle(
                                color: AppColor.skBlack,
                                fontFamily: fontFamilyCustom,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          TextSpan(
                            text: 'plants/lot',
                            style: TextStyle(
                              fontFamily: fontFamilyCustom,
                              fontSize: 14,
                              color: AppColor.skGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "\$1300/-",
                      style: TextStyle(
                        fontFamily: fontFamilyCustom,
                        fontSize: 14,
                        color: AppColor.skGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
                width: 100,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            color: AppColor.skWhite,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {},
                            iconSize: 20,
                            icon: const Icon(
                              Icons.remove,
                            )),
                      ),
                      const Text(
                        '2',
                        style: TextStyle(
                          fontFamily: fontFamilyCustom,
                          fontSize: 18,
                          color: AppColor.skBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            color: AppColor.skWhite,
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: () {},
                            iconSize: 20,
                            icon: const Icon(
                              Icons.add,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
