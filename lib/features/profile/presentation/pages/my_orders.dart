import 'package:flutter/material.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'dart:math' as math;

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<String> imageList = <String>[
    AppImages.kBrinjal,
    AppImages.kChilli,
    AppImages.kMarigold,
    AppImages.kTomato
  ];
  final int searchLength = 5;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, headerSliverBuilder) {
            return <Widget>[
              welcomeSliverAppBar(),
            ];
          },
          body: ListView.builder(
              shrinkWrap: true,
              itemCount: imageList.length,
              padding: EdgeInsets.only(
                bottom: getHeight(12.0),
                top: getHeight(12.0),
                left: getWidth(16.0),
                right: getWidth(16.0),
              ),
              itemBuilder: (context, index) {
                int randomIndex = math.Random().nextInt(imageList.length);
                String plant = imageList[randomIndex];
                return Padding(
                  padding: EdgeInsets.all(getHeight(4.0)).copyWith(
                    bottom: getHeight(10.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.trackOrder,
                          arguments: {'id': '66323'});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getWidth(10.00),
                        vertical: getHeight(10.00),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.skWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withValues(alpha: 0.2), // Adjust opacity
                              offset: Offset(
                                  0, 2.5), // Move shadow in x and y directions
                              blurRadius:
                                  4.0, // Increase blur for better visibility
                              spreadRadius: 2.5, // Increase spread
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order#: 66323',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      height: getHeight(6.0),
                                    ),
                                    Text(
                                      '15-Dec-2025, 1:00 PM',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColor.skGrey400),
                                    ),
                                  ],
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  plant,
                                  height: getHeight(70),
                                  width: getWidth(80),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    index % 2 == 1
                                        ? 'Will be delived by 16 Dec'
                                        : 'Delivered on 16 Dec',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: index % 2 == 1
                                                ? AppColor.skDarkGreen
                                                : AppColor.skOrange),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'You Rated',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    SizedBox(
                                      width: getWidth(4.0),
                                    ),
                                    SizedBox(
                                      height: getHeight(30),
                                      width: getWidth(20) * 5,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 5,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, ratingIndex) {
                                            return Padding(
                                              padding: EdgeInsets.all(
                                                  getHeight(2.0)),
                                              child: Icon(
                                                Icons.star_border_outlined,
                                                size: getHeight(20),
                                                color: AppColor.skOrange,
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget welcomeSliverAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'My Orders',
      trailingChild: SizedBox.shrink(),
    );
  }
}
