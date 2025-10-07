import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/common/custom_tile.dart';
import 'package:online_plants_app/common/product_card.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/utils/size.dart';

class WishlistProducts extends StatefulWidget {
  const WishlistProducts({super.key});

  @override
  State<WishlistProducts> createState() => _WishlistProductsState();
}

class _WishlistProductsState extends State<WishlistProducts> {
  List<String> imageList = <String>[
    AppImages.kBrinjal,
    AppImages.kChilli,
    AppImages.kMarigold,
    AppImages.kTomato
  ];
  final int searchLength = 8;
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
                        text: '8 Wishlist Found',
                      );
                    } else if (index == searchLength - 1) {
                      return CustomTile(
                        text: 'You have reached the end!!!',
                      );
                    } else {
                      return ProductCard(
                        index: index,
                        fromWishlist: true,
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
      title: 'Wishlist',
      trailingChild: SizedBox.shrink(),
    );
  }
}
