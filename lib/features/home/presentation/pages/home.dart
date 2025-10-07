import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/common/animate_product_to_cart.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';
import 'package:online_plants_app/core/services_data/model/user_model.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_bloc.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_event.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_state.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_bloc.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_state.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:online_plants_app/features/cart/presentation/bloc/cart_cubit_bloc.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_event.dart';
import 'package:online_plants_app/features/home/presentation/widgets/plants_carousel.dart';
import 'package:online_plants_app/features/home/presentation/widgets/plants_listing_horizontal.dart';
import 'package:online_plants_app/features/home/presentation/widgets/plants_listing_vertical.dart';

class Home extends StatefulWidget {
  final NotchBottomBarController? controller;
  const Home({super.key, this.controller});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  UserModel? _userModel;

  late BottomNavigationBloc _bottomNavigationBloc;

  late CartCubit _cartCubit;

  late SellerInfoBloc _sellerInfoBloc;

  GlobalKey cartKey = GlobalKey();

  void addToCartAnimation(GlobalKey productKey, String index, String asset) {
    try {
      final RenderBox? box =
          productKey.currentContext?.findRenderObject() as RenderBox?;

      final RenderBox? cartBox =
          cartKey.currentContext?.findRenderObject() as RenderBox?;

      if (box != null && cartBox != null) {
        final Offset productPosition =
            box.localToGlobal(Offset(getWidth(35), getHeight(30)));

        final Offset cartPosition = cartBox.localToGlobal(Offset.zero);

        OverlayEntry? entry;

        entry = OverlayEntry(
          builder: (context) {
            return AnimateProductToCart(
              productPosition: productPosition,
              cartPosition: cartPosition,
              onAnimationEnd: () {
                entry?.remove(); // Remove safely
                context.read<CartCubit>().addToCart();
              },
              heroKey: "product_${index}_$asset",
              url: asset,
            );
          },
        );

        Overlay.of(context).insert(entry);
      }
    } catch (e, stack) {
      print('error ${e.toString()} .. ${stack.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    _bottomNavigationBloc = context.read<BottomNavigationBloc>();
    _cartCubit = context.read<CartCubit>();
    _sellerInfoBloc = context.read<SellerInfoBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sellerInfoBloc.add(GetSellerInfoEvent(Constants.goreshwarId));
  }

  List<String> titles = <String>[
    "Most Popular",
    "Today Special",
    "New Stocks",
    "All Plants",
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
              ];
            },
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<UserInfoBloc, UserInfoState>(
                      builder: (context, state) {
                    if ((_userModel?.isAdmin ?? false)) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidth(40), vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.adminDashboard);
                                },
                                child: Text(
                                  'Go To Admin Panel',
                                  style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: AppColor.skWhite) ??
                                      TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.skWhite,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  }, listener: (context, state) {
                    if (state is GetUserInfoSuccess) {
                      if (state.model != null) {
                        _userModel = state.model;
                      }
                    }
                  }),
                  PlantsCarousel(),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PlantsListingHorizontal(
                          id: index.toString(),
                          index: index,
                          title: titles.elementAt(index),
                          addToCartAnimation: (productKey, id, asset) {
                            addToCartAnimation(productKey, "$index$id", asset);
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: getHeight(10),
                          ),
                      itemCount: titles.length),
                  PlantsListingVertical(
                    id: ('300').toString(),
                    index: 300,
                    title: "Goreshwar Special",
                    addToCartAnimation: (productKey, id, asset) {
                      addToCartAnimation(productKey, "300$id", asset);
                    },
                  ),
                  SizedBox(
                    height: getHeight(Dimens.kBottomBarHeight),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  SellerModel? _sellerModel;
  Widget welcomeSliverAppBar() {
    return BlocConsumer<SellerInfoBloc, SellerInfoState>(
        listener: (context, state) {
      if (state is GetSellerInfoSuccess) {
        _sellerModel = state.model;
      }
      if (state is AddUpdateSellerInfoSuccess) {}
    }, builder: (context, state) {
      return CustomAppBar(
        appBarType: AppBarType.profile,
        title: 'Welcome to',
        subTitle: _sellerModel?.mainNurseryName ?? 'Goreshwar Hi-Tech Nursery',
        profileImage: Hero(
          tag: 'AdminProfile',
          child: Stack(
            children: [
              // Placeholder or Error Image
              CircleAvatar(
                radius: getHeight(22),
                backgroundImage:
                    AssetImage(AppImages.kGoreshwarLogo), // Placeholder image
              ),
              // Cached Network Image
              CircleAvatar(
                radius: getHeight(22),
                backgroundColor:
                    Colors.transparent, // Ensure transparency for layering
                backgroundImage: CachedNetworkImageProvider(
                  _sellerModel?.imageUrl ?? '',
                ),
                onBackgroundImageError: (_, __) {},
              ),
            ],
          ),
        ),
        trailingChild: GestureDetector(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                key: cartKey,
                Icons.shopping_cart,
                size: getHeight(24),
                color: AppColor.skGreenColor,
              ),
              Positioned(
                top: -5,
                left: -5,
                child: CircleAvatar(
                  backgroundColor: AppColor.skAppBackground,
                  radius: 8.0,
                  child: BlocBuilder<CartCubit, CartCubitBloc>(
                      builder: (context, state) {
                    return Center(
                      child: Text(
                        '${state.itemCount}',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColor.skRed),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          onTap: () {
            _bottomNavigationBloc.add(BottomNavigationPageChanged(1));
          },
        ),
        callback: () {
          if (_sellerModel != null) {
            Navigator.of(context).pushNamed(
              AppRoutes.adminProfile,
              arguments: {'fromAdmin': false, 'seller': _sellerModel!},
            );
          }
        },
      );
    });
  }
}
