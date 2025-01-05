import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> imageList = <String>[
    AppImages.kBrinjal,
    AppImages.kChilli,
    AppImages.kMarigold,
    AppImages.kTomato
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, headerSliverBuilder) {
            return <Widget>[
              welcomeSliverAppBar(),
              searchSliverAppBar(),
            ];
          },
          body: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                MasonryGridView.count(
                  padding: EdgeInsets.symmetric(
                      vertical: getHeight(2), horizontal: getWidth(25)),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 11,
                  crossAxisCount: 2,
                  mainAxisSpacing: getHeight(10),
                  crossAxisSpacing: getWidth(23),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return tile(
                        text: '8 Products Found',
                      );
                    } else if (index == 1) {
                      return tile(
                        text: '',
                      );
                    } else if (index == 11 - 1) {
                      return tile(
                        text: 'You have reached the end!!!',
                      );
                    } else {
                      return getCard(index);
                    }
                  },
                ),
                SizedBox(
                  height: getHeight(80),
                ),
              ]),
        ),
      ),
    );
  }

  Widget getCard(int index) {
    double opacity = 0.1 * (index % 11); // Calculate opacity dynamically
    // ignore: unused_local_variable
    Color greenColor = AppColor.skGreen.withOpacity(opacity);
    int randomIndex = Random().nextInt(imageList.length);
    String plant = imageList[randomIndex];
    return Card(
      color: greenColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getHeight(15)),
      ),
      child: SizedBox(
        height: getHeight(210),
        width: getWidth(130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getWidth(5),
                right: getWidth(5),
                top: getHeight(10),
                bottom: getHeight(10),
              ),
              child: Container(
                height: getHeight(135),
                width: getWidth(115),
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
                  borderRadius: BorderRadius.circular(getHeight(12)),
                  child: Image(
                    image: AssetImage(plant),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getHeight(2)),
              child: Padding(
                padding: EdgeInsets.all(getHeight(5)),
                child: SizedBox(
                  width: getWidth(110),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getHeight(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Marigold",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            Text.rich(
                              TextSpan(
                                  text: '\u{20B9} ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                      text: '20/-',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
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
                              color: AppColor.skWhite,
                              borderRadius:
                                  BorderRadius.circular(getHeight(8))),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                              size: getHeight(20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tile({
    required String text,
  }) {
    return text.isEmpty
        ? const SizedBox.shrink()
        : Container(
            padding: EdgeInsets.all(getHeight(5)),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 25,
                    // color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          );
  }

  Widget welcomeSliverAppBar() {
    return const SliverAppBar(
      // backgroundColor: AppColor.skWhite,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Search Products',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColor.skGrey,
          ),
        ),
      ),
    );
  }

  Widget searchSliverAppBar() {
    return SliverAppBar(
      // backgroundColor: AppColor.skWhite,
      floating: true,
      pinned: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(getHeight(5)),
                bottomLeft: Radius.circular(getHeight(5)))),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: getWidth(16), right: getWidth(50)),
            child: SizedBox(height: getHeight(40), child: searchField()),
          ),
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(getHeight(5)),
                  bottomRight: Radius.circular(getHeight(5)))),
          child: GestureDetector(
            child: Icon(
              Icons.grid_view_rounded,
              color: AppColor.skGreen,
              size: getHeight(40),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget searchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(getHeight(8.0)),
        ),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
