import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/common/custom_tile.dart';
import 'package:online_plants_app/common/product_card.dart';
import 'package:online_plants_app/common/round_grid_view.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final int searchLength = 20;
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
                  itemCount: searchLength,
                  crossAxisCount: 2,
                  mainAxisSpacing: getHeight(10),
                  crossAxisSpacing: getWidth(23),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CustomTile(
                        text: '8 Products Found',
                      );
                    } else if (index == searchLength - 1) {
                      return CustomTile(
                        text: 'You have reached the end!!!',
                      );
                    } else {
                      return ProductCard(
                        index: index,
                        fromWishlist: false,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: getHeight(Dimens.kBottomBarHeight),
                ),
              ]),
        ),
      ),
    );
  }

  Widget welcomeSliverAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'Search Products',
      pinned: false,
      floating: false,
    );
  }

  Widget searchSliverAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.search,
      title: 'Search',
      searchChild: searchField(),
      trailingChild: RoundGridView(
        onTap: () {},
      ),
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
