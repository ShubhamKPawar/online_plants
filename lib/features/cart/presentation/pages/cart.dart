import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
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
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  Timer? _timer;
  int length = 5; // Changed to a value greater than 3 for testing
  late CartCubit _cartCubit;
  void _startTimer() {
    _timer?.cancel();
    _animationController.forward().then((value) {
      _cartCubit.toggleShowContainer(true);
    });

    _timer = Timer(const Duration(seconds: 10), () {
      _animationController.reverse().then((value) {
        _cartCubit.toggleShowContainer(false);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection !=
              ScrollDirection.idle &&
          length > 3) {
        _startTimer();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartCubit = context.read<CartCubit>();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    _animationController.dispose();
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
              const SliverAppBar(
                backgroundColor: AppColor.skWhite,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'My Cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: fontFamilyCustom,
                      fontWeight: FontWeight.bold,
                      color: AppColor.skGrey,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MyCartItems(index: index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: length,
                ),
              ),
              BlocBuilder<CartCubit, CartCubitBloc>(builder: (context, bloc) {
                return bloc.showContainer
                    ? SlideTransition(
                        position: _offsetAnimation,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          child: Container(
                            height: 170,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: AppColor.skGrey200,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                          color: AppColor.skGrey200,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sub Total',
                                                style: TextStyle(
                                                  color: AppColor.skGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: fontFamilyCustom,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '\$30.00',
                                                style: TextStyle(
                                                  color: AppColor.skGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: fontFamilyCustom,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30),
                                          ),
                                          color: AppColor.skGrey100,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total',
                                                style: TextStyle(
                                                  color: AppColor.skBlack,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: fontFamilyCustom,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                '\$30.00',
                                                style: TextStyle(
                                                  color: AppColor.skBlack,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: fontFamilyCustom,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 200,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColor.skBlack,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Buy Now',
                                      style: TextStyle(
                                        fontFamily: fontFamilyCustom,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.skWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
