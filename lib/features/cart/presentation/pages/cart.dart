import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/common/app_text_button.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/theme/theme_data/app_text_styles.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit_bloc.dart';
import 'package:online_plants_app/features/cart/presentation/widgets/my_cart.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  int length = 5; // Changed to a value greater than 3 for testing

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                welcomeAppBar(),
              ];
            },
            body: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: length,
                          itemBuilder: (context, index) =>
                              MyCartItems(index: index),
                        ),
                        SizedBox(height: 20),
                        _finalWidget(context),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  Widget _finalWidget(BuildContext context) {
    return Container(
      height: getHeight(130),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: Dimens.kBottomBarHeight + 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getHeight(30)),
          topRight: Radius.circular(getHeight(30)),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(getHeight(30)),
          topRight: Radius.circular(getHeight(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.skGrey200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(getHeight(30)),
                  topRight: Radius.circular(getHeight(30)),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: getHeight(40),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getHeight(30)),
                        topRight: Radius.circular(getHeight(30)),
                      ),
                      color: AppColor.skGrey200,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getHeight(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub Total',
                            style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColor.skGreenColor,
                                        fontWeight: FontWeight.w700) ??
                                TextStyle(
                                  color: AppColor.skGreenColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                          ),
                          Text.rich(
                            TextSpan(
                                text: '\u{20B9} ',
                                style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: AppColor.skGreenColor,
                                        ) ??
                                    TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                    text: '20/-',
                                    style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontFamily: AppTextStyles
                                                  .numberFontFamily,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.skGreenColor,
                                            ) ??
                                        TextStyle(
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
                  ),
                  Container(
                    height: getHeight(40),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(getHeight(30)),
                        topRight: Radius.circular(getHeight(30)),
                      ),
                      color: AppColor.skGrey100,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getHeight(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Final Total',
                            style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColor.skGreenColor,
                                        fontWeight: FontWeight.w700) ??
                                TextStyle(
                                  color: AppColor.skGreenColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                          ),
                          Text.rich(
                            TextSpan(
                                text: '\u{20B9} ',
                                style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: AppColor.skGreenColor,
                                        ) ??
                                    TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                children: [
                                  TextSpan(
                                    text: '20/-',
                                    style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontFamily: AppTextStyles
                                                  .numberFontFamily,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.skGreenColor,
                                            ) ??
                                        TextStyle(
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
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: getHeight(5.0)),
              height: getHeight(50),
              width: getWidth(180),
              child: AppTextButton(
                onPressed: () {},
                text: 'Checkout',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget welcomeAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'My Cart',
      pinned: true,
      floating: true,
    );
  }
}
