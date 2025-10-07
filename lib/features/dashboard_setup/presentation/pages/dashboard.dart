import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_bloc.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_event.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_bloc.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_event.dart';
import 'package:online_plants_app/features/dashboard_setup/presentation/bloc/bottom_navigation_state.dart';
import 'package:online_plants_app/features/cart/presentation/pages/cart.dart';
import 'package:online_plants_app/features/home/presentation/pages/home.dart';
import 'package:online_plants_app/features/profile/presentation/pages/profile.dart';
import 'package:online_plants_app/features/search/presentation/pages/search.dart';
import 'package:online_plants_app/features/timeline/presentation/pages/lateset_timeline.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  late BottomNavigationBloc bloc;
  late UserInfoBloc _userInfoBloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BottomNavigationBloc>();
    _controller.addListener(() {
      final int index = _controller.index;
      bloc.add(BottomNavigationTabChanged(index));
    });
    _userInfoBloc = context.read<UserInfoBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userInfoBloc.add(GetUserInfoEvent());
  }

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Stack(children: [
          ClipRRect(
            child: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
              listener: (context, state) {
                if (state is BottomNavigationTabState) {
                  if (mounted) {
                    tabIndex = state.tabIndex;
                  }
                }

                if (state is BottomNavigationPageChangeState) {
                  if (mounted) {
                    tabIndex = state.tabIndex;
                    _controller.jumpTo(state.tabIndex);
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
                    LatestTimeline(),
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
              color: Constants.isDark ? AppColor.skBlack : AppColor.skWhite,
              showLabel: false,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: Dimens.kBottomBarShadowElevation,
              kBottomRadius: getHeight(Dimens.kBottomBarRadius),
              notchColor: AppColor.skGreen,
              removeMargins: false,
              bottomBarWidth: MediaQuery.of(context).size.width,
              showShadow: true,
              durationInMilliSeconds: Dimens.kBottomBarDurationInMilliSeconds,
              itemLabelStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColor.skGreenColor),
              elevation: Dimens.kBottomBarElevation,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: AppColor.skGreenColor,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: AppColor.skWhite,
                  ),
                  itemLabelWidget: _labelText('Home'),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.shopping_cart,
                    color: AppColor.skGreenColor,
                  ),
                  activeItem: Icon(
                    Icons.shopping_cart,
                    color: AppColor.skWhite,
                  ),
                  itemLabelWidget: _labelText('Cart'),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.search,
                    color: AppColor.skGreenColor,
                  ),
                  activeItem: Icon(
                    Icons.search,
                    color: AppColor.skWhite,
                  ),
                  itemLabelWidget: _labelText('Search'),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.timeline,
                    color: AppColor.skGreenColor,
                  ),
                  activeItem: Icon(
                    Icons.timeline,
                    color: AppColor.skWhite,
                  ),
                  itemLabelWidget: _labelText('Timeline'),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.person,
                    color: AppColor.skGreenColor,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: AppColor.skWhite,
                  ),
                  itemLabelWidget: _labelText('Profile'),
                ),
              ],
              onTap: (index) {
                _controller.index = index;
                bloc.add(BottomNavigationTabChanged(index));
              },
              kIconSize: getHeight(Dimens.kBottomBarIconSize),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _labelText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColor.skGreenColor),
        ),
      ),
    );
  }
}
