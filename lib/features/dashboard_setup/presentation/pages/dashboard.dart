import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_event.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_state.dart';
import 'package:online_plants_app/features/cart/presentation/pages/cart.dart';
import 'package:online_plants_app/features/home/presentation/pages/home.dart';
import 'package:online_plants_app/features/profile/presentation/pages/profile.dart';
import 'package:online_plants_app/features/search/presentation/pages/search.dart';
import 'package:online_plants_app/features/timeline/presentation/pages/timeline.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  late BottomNavigationBloc bloc;

  @override
  void initState() {
    bloc = context.read<BottomNavigationBloc>();
    _controller.addListener(() {
      final int index = _controller.index;
      bloc.add(BottomNavigationTabChanged(index));
    });
    super.initState();
  }

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0)),
            child: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
              listener: (context, state) {
                if (state is BottomNavigationTabState) {
                  if (mounted) {
                    tabIndex = state.tabIndex;
                  }
                }
              },
              builder: (context, state) {
                return IndexedStack(
                  index: tabIndex,
                  children: const [
                    Home(),
                    Cart(),
                    Search(),
                    Timeline(),
                    Profile(),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: isDark ? AppColor.skBlack : AppColor.skWhite,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 8,
              kBottomRadius: 24.0,
              notchColor: AppColor.skGreen,
              removeMargins: false,
              bottomBarWidth: MediaQuery.of(context).size.width,
              showShadow: true,
              durationInMilliSeconds: 300,
              itemLabelStyle:
                  const TextStyle(fontSize: 12, fontFamily: fontFamilyCustom),
              elevation: 2,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: AppColor.skGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: AppColor.skWhite,
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.shopping_cart,
                    color: AppColor.skGrey,
                  ),
                  activeItem: Icon(
                    Icons.shopping_cart,
                    color: AppColor.skWhite,
                  ),
                  itemLabel: 'Cart',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.search,
                    color: AppColor.skGrey,
                  ),
                  activeItem: Icon(
                    Icons.search,
                    color: AppColor.skWhite,
                  ),
                  itemLabel: 'Search',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.timeline,
                    color: AppColor.skGrey,
                  ),
                  activeItem: Icon(
                    Icons.timeline,
                    color: AppColor.skWhite,
                  ),
                  itemLabel: 'Timeline',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: AppColor.skGrey,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: AppColor.skWhite,
                  ),
                  itemLabel: 'Profile',
                ),
              ],
              onTap: (index) {
                _controller.index = index;
                bloc.add(BottomNavigationTabChanged(index));
              },
              kIconSize: 15.0,
            ),
          ),
        ]),
      ),
    );
  }
}
