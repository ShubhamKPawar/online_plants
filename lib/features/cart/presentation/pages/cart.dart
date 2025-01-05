import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  Timer? _timer;
  int length = 2; // Changed to a value greater than 3 for testing
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
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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
                // backgroundColor: AppColor.skWhite,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'My Cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MyCartItems(index: index);
                  },
                  itemCount: length,
                ),
              ),
              BlocBuilder<CartCubit, CartCubitBloc>(builder: (context, bloc) {
                return bloc.showContainer
                    ? SlideTransition(
                        position: _offsetAnimation,
                        child: Container(
                          height: getHeight(130),
                          width: MediaQuery.of(context).size.width,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.circular(getHeight(30)),
                                            topRight:
                                                Radius.circular(getHeight(30)),
                                          ),
                                          color: AppColor.skGrey200,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getHeight(30)),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Sub Total',
                                                style: TextStyle(
                                                  color: AppColor.skGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                    text: '\u{20B9} ',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    children: [
                                                      TextSpan(
                                                        text: '20/-',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.circular(getHeight(30)),
                                            topRight:
                                                Radius.circular(getHeight(30)),
                                          ),
                                          color: AppColor.skGrey100,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getHeight(30)),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Final Total',
                                                style: TextStyle(
                                                  color: AppColor.skGrey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                    text: '\u{20B9} ',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    children: [
                                                      TextSpan(
                                                        text: '20/-',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
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
                                SizedBox(
                                  height: getHeight(45),
                                  width: getWidth(180),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColor.skBlack,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            getHeight(10)),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Buy Now',
                                      style: TextStyle(
                                        fontSize: 15,
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
              SizedBox(
                height: getHeight(90),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
