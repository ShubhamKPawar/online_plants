import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
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

  // Handle scroll notifications
  // void _onScroll() {}
  Widget welcomeSliverAppBar() {
    return SliverAppBar(
      flexibleSpace: const FlexibleSpaceBar(
        expandedTitleScale: 1,
        title: Row(
          children: [
            CircleAvatar(
              minRadius: 25,
              maxRadius: 25,
              backgroundImage: AssetImage(AppImages.kGoreshwarLogo),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: fontFamilyCustom,
                      fontWeight: FontWeight.bold,
                      color: AppColor.skGrey,
                    ),
                  ),
                  Text(
                    'Goreshwar Hi-Tech Nursery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: fontFamilyCustom,
                      color: AppColor.skGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        titlePadding: EdgeInsets.only(left: 16.0, bottom: 0.0, top: 2),
        centerTitle: false,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            size: 24,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget searchSliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: true,
      flexibleSpace: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 50),
          child: SizedBox(height: 40, child: searchField()),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.grid_view_rounded,
            color: AppColor.skGreen,
            size: 40,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget searchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: const Icon(Icons.search),
      ),
    );
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
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, headerSliverBuilder) {
              return <Widget>[
                welcomeSliverAppBar(),
                searchSliverAppBar(),
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
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: titles.length),
                ),
                const SizedBox(
                  height: 90,
                ),
              ],
            )),
      ),
    );
  }
}
