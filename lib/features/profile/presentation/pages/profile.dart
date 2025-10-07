import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/common/custom_dropdown.dart';
import 'package:online_plants_app/common/list_tiles.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/locale/locale_manager.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_bloc.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_event.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_manager.dart';
import 'package:online_plants_app/core/services_data/user_info_bloc/user_info_state.dart';
import 'package:online_plants_app/core/theme/bloc/theme_manager.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/di/init_di.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserInfoManager _userInfoManager = dependencyLocator<UserInfoManager>();
  final ThemeManager _themeManager = dependencyLocator<ThemeManager>();
  final LocaleManager _localeManager = dependencyLocator<LocaleManager>();
  final List<String> languageList = ['English'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, headerSliverBuilder) {
            return <Widget>[
              welcomeSliverAppBar(() {
                Navigator.of(context).pushNamed(AppRoutes.userProfile);
              }, () {
                Navigator.of(context).pushNamed(AppRoutes.userNotifications);
              }),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox) / 2),

                //Account
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHeight(Dimens.kProfilePaddingBox),
                      vertical: getHeight(Dimens.kProfilePaddingBox) / 2),
                  child: Text(
                    "Account",
                    style: Theme.of(context).textTheme.headlineSmall ??
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox) / 2),
                Divider(height: Dimens.skDividerHeight),
                MenuListTile(
                  text: "My Profile",
                  svgSrc: AppImages.profileSvg,
                  press: () {
                    Navigator.of(context).pushNamed(AppRoutes.userProfile);
                  },
                ),
                MenuListTile(
                  text: "Orders",
                  svgSrc: AppImages.orderSvg,
                  press: () {
                    Navigator.of(context).pushNamed(AppRoutes.myOrders);
                  },
                ),

                MenuListTile(
                  text: "Wishlist",
                  svgSrc: AppImages.wishlistSvg,
                  press: () {
                    Navigator.of(context).pushNamed(AppRoutes.wishlistProducts);
                  },
                ),
                MenuListTile(
                  text: "Addresses",
                  svgSrc: AppImages.addressSvg,
                  press: () {
                    Navigator.of(context).pushNamed(AppRoutes.userAddresses);
                  },
                ),
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox)),
                //Personalization
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHeight(Dimens.kProfilePaddingBox),
                      vertical: getHeight(Dimens.kProfilePaddingBox) / 2),
                  child: Text(
                    "Personalization",
                    style: Theme.of(context).textTheme.headlineSmall ??
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox)),

                Divider(height: Dimens.skDividerHeight),
                MenuItemListTile(
                  leading: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: AppColor.skWhite,
                      image: DecorationImage(
                        image: AssetImage(
                          AppImages.preferencesSvg,
                        ),
                      ),
                    ),
                  ),
                  text: "Dark Mode",
                  trailing: Container(
                    height: getHeight(24),
                    width: getWidth(13),
                    margin: EdgeInsets.only(right: getWidth(15)),
                    child: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                        value: _themeManager.isDarkTheme,
                        onChanged: (newValue) {
                          if (newValue != _themeManager.isDarkTheme) {
                            if (newValue) {
                              _themeManager.setDarkTheme();
                            } else {
                              _themeManager.setLightTheme();
                            }
                          }
                        },
                        activeTrackColor: AppColor.skGreenColor,
                        thumbColor: AppColor.skGreen,
                      ),
                    ),
                  ),
                  onTap: () {
                    bool newValue = _themeManager.isDarkTheme;
                    if (newValue) {
                      _themeManager.setDarkTheme();
                    } else {
                      _themeManager.setLightTheme();
                    }
                  },
                ),

                Divider(height: Dimens.skDividerHeight),
                BlocBuilder<UserInfoManager, UserInfoManageState>(
                    buildWhen: (previous, current) =>
                        previous.name != current.name,
                    builder: (context, state) {
                      return MenuItemListTile(
                        leading: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: AppColor.skWhite,
                            image: DecorationImage(
                              image: AssetImage(
                                AppImages.notificationSvg,
                              ),
                            ),
                          ),
                        ),
                        text: "Notification",
                        trailing: Container(
                          height: getHeight(24),
                          width: getWidth(13),
                          margin: EdgeInsets.only(right: getWidth(15)),
                          child: Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: _userInfoManager.isNotification,
                              onChanged: (newValue) {
                                if (newValue) {
                                  _userInfoManager.activeNotification();
                                } else {
                                  _userInfoManager.inactiveNotification();
                                }
                              },
                              activeTrackColor: AppColor.skGreenColor,
                              thumbColor: AppColor.skGreen,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (_userInfoManager.isNotification) {
                            _userInfoManager.inactiveNotification();
                          } else {
                            _userInfoManager.activeNotification();
                          }
                        },
                      );
                    }),

                Divider(height: Dimens.skDividerHeight),

                //Settings
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox)),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHeight(Dimens.kProfilePaddingBox),
                      vertical: getHeight(Dimens.kProfilePaddingBox) / 2),
                  child: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headlineSmall ??
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox)),
                const Divider(height: Dimens.skDividerHeight),
                MenuItemListTile(
                  leading: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: AppColor.skWhite,
                      image: DecorationImage(
                        image: AssetImage(
                          AppImages.languageSvg,
                        ),
                      ),
                    ),
                  ),
                  text: "Language",
                  trailing: SizedBox(
                    width: getWidth(120),
                    child: CustomDropdown(
                        items: languageList,
                        initial:
                            getInitialLanguage(_localeManager.currentLanguage),
                        onItemSelected: (val) async {
                          bool appRestart = false;

                          if (_localeManager.currentLanguage !=
                              getCodeFromLanguage(val)) {
                            appRestart = true;
                          } else {
                            appRestart = false;
                          }
                          if (val == languageList[0]) {
                            BlocProvider.of<LocaleManager>(context,
                                    listen: false)
                                .changeLocale(const Locale('en'));
                          }
                        }),
                  ),
                  onTap: () {},
                ),

                Divider(height: Dimens.skDividerHeight),

                BlocBuilder<UserInfoManager, UserInfoManageState>(
                    buildWhen: (previous, current) {
                  return previous.name != current.name;
                }, builder: (context, state) {
                  return MenuItemListTile(
                    leading: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: AppColor.skWhite,
                        image: DecorationImage(
                          image: AssetImage(
                            AppImages.locationSvg,
                          ),
                        ),
                      ),
                    ),
                    text: "Location",
                    trailing: Container(
                      height: getHeight(24),
                      width: getWidth(13),
                      margin: EdgeInsets.only(right: getWidth(15)),
                      child: GestureDetector(
                        onTap: () {
                          if (_userInfoManager.isLocation) {
                            _userInfoManager.inactiveLocation();
                          } else {
                            _userInfoManager.activeLocation();
                          }
                        },
                        child: _userInfoManager.isLocation
                            ? Icon(Icons.location_on_outlined)
                            : Icon(Icons.location_off_outlined),
                      ),
                    ),
                    onTap: () {
                      if (_userInfoManager.isLocation) {
                        _userInfoManager.inactiveLocation();
                      } else {
                        _userInfoManager.activeLocation();
                      }
                    },
                  );
                }),

                Divider(height: Dimens.skDividerHeight),
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox)),

                //Help and Centre
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getHeight(Dimens.kProfilePaddingBox),
                      vertical: getHeight(Dimens.kProfilePaddingBox) / 2),
                  child: Text(
                    "Help & Support",
                    style: Theme.of(context).textTheme.headlineSmall ??
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox)),
                const Divider(height: Dimens.skDividerHeight),
                MenuListTile(
                  text: "Get Help",
                  svgSrc: AppImages.helpSvg,
                  press: () {},
                ),
                MenuListTile(
                  text: "FAQ",
                  svgSrc: AppImages.fAQSvg,
                  press: () {},
                ),
                SizedBox(height: getHeight(Dimens.kProfilePaddingBox)),
                // Log Out
                BlocConsumer<UserInfoBloc, UserInfoState>(
                    listener: (context, state) {
                  if (state is LoggedOutSuccess) {
                    _userInfoManager.checkLoggedIn();
                  }
                }, builder: (context, state) {
                  return BlocBuilder<UserInfoManager, UserInfoManageState>(
                      buildWhen: (previous, current) =>
                          previous.name != current.name,
                      builder: (context, state) {
                        return ListTile(
                          onTap: () {
                            if (_userInfoManager.isLoggedIn) {
                              context
                                  .read<UserInfoBloc>()
                                  .add(UserLoggedOutEvent(isSkip: false));
                            } else {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.loginRoute);
                            }
                          },
                          minLeadingWidth: getWidth(24),
                          leading: _userInfoManager.isLoggedIn
                              ? Image.asset(
                                  AppImages.logoutSvg,
                                  height: getHeight(24),
                                  width: getWidth(24),
                                )
                              : Image.asset(
                                  AppImages.logoutSvg,
                                  height: getHeight(24),
                                  width: getWidth(24),
                                  color: AppColor.skGreen,
                                ),
                          title: _userInfoManager.isLoggedIn
                              ? Text(
                                  "Log Out",
                                  style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(color: AppColor.skRed) ??
                                      TextStyle(
                                          color: AppColor.skRed,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                )
                              : Text(
                                  "Log In",
                                  style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(color: AppColor.skGreen) ??
                                      TextStyle(
                                          color: AppColor.skGreen,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                ),
                        );
                      });
                }),
                SizedBox(
                  height: getHeight(Dimens.kBottomBarHeight),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welcomeSliverAppBar(
      VoidCallback callback, VoidCallback notificationCallback) {
    return CustomAppBar(
      appBarType: AppBarType.profile,
      title: 'Hi Shubham Pawar',
      subTitle: 'shubham@gmail.com',
      profileImage: Hero(
        tag: 'profile_kUserProfile',
        child: CircleAvatar(
          radius: getHeight(22),
          backgroundImage: AssetImage(AppImages.kGoreshwarLogo),
        ),
      ),
      trailingChild: GestureDetector(
        onTap: notificationCallback,
        child: Icon(
          Icons.notifications,
          size: getHeight(24),
        ),
      ),
      callback: callback,
    );
  }

  String getInitialLanguage(String languageCode) {
    if (languageCode.toLowerCase() == 'en') {
      return languageList[0];
    } else {
      return languageList[0];
    }
  }

  String getCodeFromLanguage(String language) {
    String value = 'en';
    switch (language) {
      case "English":
        value = 'en';
        break;
      default:
        value = 'en';
        break;
    }

    return value;
  }
}
