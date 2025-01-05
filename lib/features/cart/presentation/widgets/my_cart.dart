import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
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
    double opacity = 0.1 * (widget.index % 10);
    Color greenColor = AppColor.skGreen.withOpacity(opacity);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: getHeight(widget.index == 0 ? 43 : 15),
          horizontal: getWidth(10)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
            color: greenColor,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getHeight(20)),
            ),
            child: SizedBox(
              height: getHeight(120),
              width: getWidth(392),
              child: Padding(
                padding: EdgeInsets.only(
                    left: getWidth(160),
                    top: getHeight(20),
                    bottom: getHeight(20),
                    right: getWidth(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Marigold",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '120 ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              TextSpan(
                                text: 'plants/lot',
                                style: TextStyle(
                                  fontSize: 10,
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
                                  fontSize: 18, fontWeight: FontWeight.w400),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: getHeight(25),
                          width: getHeight(25),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              color: AppColor.skWhite,
                              borderRadius:
                                  BorderRadius.circular(getHeight(8))),
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              color: AppColor.skBlack,
                              size: getHeight(20),
                            ),
                          ),
                        ),
                        const Text(
                          '2',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: getHeight(25),
                          width: getHeight(25),
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              color: AppColor.skWhite,
                              borderRadius:
                                  BorderRadius.circular(getHeight(8))),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: AppColor.skBlack,
                              size: getHeight(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -getHeight(45),
            left: getWidth(10),
            child: Card(
              color: greenColor,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(getHeight(20)),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: getWidth(10),
                      right: getWidth(10),
                      top: getHeight(10),
                      bottom: getHeight(10),
                    ),
                    child: Container(
                      height: getHeight(130),
                      width: getWidth(100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(getHeight(15)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.skBlack.withOpacity(0.6),
                                offset: const Offset(3, 3),
                                blurRadius: 0.8,
                                spreadRadius: 0.4)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(getHeight(15)),
                        child: const Image(
                          image: AssetImage(AppImages.kTomato),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: getWidth(8),
                      top: getHeight(8),
                      child: Container(
                        height: getHeight(25),
                        width: getHeight(25),
                        decoration: BoxDecoration(
                            color: AppColor.skWhite,
                            borderRadius: BorderRadius.circular(getHeight(8))),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: AppColor.skBlack,
                            size: getHeight(20),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
