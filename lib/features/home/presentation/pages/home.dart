import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/features/home/presentation/widgets/plants_listing.dart';

class Home extends StatefulWidget {
  final NotchBottomBarController? controller;
  const Home({super.key, this.controller});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<String> titles = <String>[
    "Most Popular",
    "Today Special",
    "New Stocks",
    "All Plants",
    "Goreshwar Special"
  ];
  @override
  Widget build(BuildContext context) {
    var bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, headerSliverBuilder) {
              return <Widget>[
                welcomeSliverAppBar(),
                //searchSliverAppBar(),
              ];
            },
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PlantsListing(
                            index: index, title: titles.elementAt(index));
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: getHeight(10),
                          ),
                      itemCount: titles.length),
                ),
                Container(
                  height: bottomInset > 0 ? 0 : getHeight(75),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(getHeight(15)),
                          topRight: Radius.circular(getHeight(15)))),
                ),
              ],
            )),
      ),
    );
  }

  // Handle scroll notifications
  // void _onScroll() {}
  Widget welcomeSliverAppBar() {
    return SliverAppBar(
      // backgroundColor: AppColor.skWhite,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        title: Container(
          decoration: const BoxDecoration(
              // color: AppColor.skWhite,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3))),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: getWidth(16.0)),
                child: CircleAvatar(
                  minRadius: getHeight(22),
                  maxRadius: getHeight(22),
                  backgroundImage: const AssetImage(AppImages.kGoreshwarLogo),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: getWidth(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getWidth(22),
                        fontWeight: FontWeight.bold,
                        color: AppColor.skGrey,
                      ),
                    ),
                    Text(
                      'Goreshwar Hi-Tech Nursery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getWidth(14),
                        color: AppColor.skGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        titlePadding:
            EdgeInsets.only(left: getWidth(0), bottom: 0.0, top: getHeight(0)),
        centerTitle: false,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: getHeight(8)),
          child: GestureDetector(
            child: Icon(
              Icons.shopping_cart,
              size: getHeight(24),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  // Widget searchSliverAppBar() {
  //   return SliverAppBar(
  //     backgroundColor: AppColor.skWhite,
  //     floating: true,
  //     pinned: true,
  //     flexibleSpace: Container(
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(getHeight(5)),
  //               bottomLeft: Radius.circular(getHeight(5)))),
  //       child: Center(
  //         child: Padding(
  //           padding: EdgeInsets.only(left: getWidth(16), right: getWidth(50)),
  //           child: SizedBox(height: getHeight(40), child: searchField()),
  //         ),
  //       ),
  //     ),
  //     actions: [
  //       Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //                 topRight: Radius.circular(getHeight(5)),
  //                 bottomRight: Radius.circular(getHeight(5)))),
  //         child: GestureDetector(
  //           child: Icon(
  //             Icons.grid_view_rounded,
  //             color: AppColor.skGreen,
  //             size: getHeight(40),
  //           ),
  //           onTap: () {},
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget searchField() {
  //   return TextField(
  //     decoration: InputDecoration(
  //       hintText: 'Search',
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(getHeight(8.0)),
  //       ),
  //       prefixIcon: const Icon(Icons.search),
  //     ),
  //   );
  // }
}
