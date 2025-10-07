import 'package:flutter/material.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class CustomAppBar extends StatelessWidget {
  final AppBarType appBarType;
  final Widget? profileImage;
  final String title;
  final String? subTitle;
  final Widget? trailingChild;
  final VoidCallback? callback;
  final bool pinned;
  final bool floating;
  final Widget? searchChild;
  final bool automaticallyImplyLeading;
  const CustomAppBar({
    super.key,
    required this.appBarType,
    required this.title,
    this.profileImage,
    this.subTitle,
    this.trailingChild,
    this.callback,
    this.pinned = true,
    this.floating = true,
    this.searchChild,
    this.automaticallyImplyLeading = true,
  })  : assert(
          (appBarType != AppBarType.profile ||
              (profileImage != null && subTitle != null)),
          'profileImage and subTitle cannot be null when appBarType is profile',
        ),
        assert(
          (appBarType != AppBarType.search || searchChild != null),
          'searchChild cannot be null when appBarType is search',
        );

  @override
  Widget build(BuildContext context) {
    return appBarType == AppBarType.profile
        ? SliverAppBar(
            pinned: pinned,
            floating: floating,
            automaticallyImplyLeading: automaticallyImplyLeading,
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3))),
                child: GestureDetector(
                  onTap: () {
                    callback?.call();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: getWidth(16.0)),
                        child: profileImage,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: getWidth(8)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: AppColor.skGrey) ??
                                  TextStyle(
                                    fontSize: getWidth(22),
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.skGrey,
                                  ),
                            ),
                            Text(
                              subTitle ?? '',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColor.skGrey) ??
                                  TextStyle(
                                    fontSize: getWidth(14),
                                    color: AppColor.skGrey,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              titlePadding: EdgeInsets.only(
                  left: getWidth(0), bottom: 0.0, top: getHeight(0)),
              centerTitle: false,
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: getHeight(8)),
                child: trailingChild,
              ),
            ],
          )
        : appBarType == AppBarType.search
            ? SliverAppBar(
                floating: floating,
                pinned: pinned,
                automaticallyImplyLeading: automaticallyImplyLeading,
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(getHeight(5)),
                      bottomLeft: Radius.circular(getHeight(5)),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getWidth(16), right: getWidth(40)),
                      child:
                          SizedBox(height: getHeight(40), child: searchChild),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: getHeight(8),
                      left: getWidth(8.0),
                    ),
                    child: trailingChild,
                  ),
                ],
              )
            : SliverAppBar(
                floating: pinned,
                pinned: floating,
                centerTitle: true,
                automaticallyImplyLeading: automaticallyImplyLeading,
                flexibleSpace: Center(
                  child: SizedBox(
                      height: getHeight(40),
                      child: Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColor.skGrey) ??
                              TextStyle(
                                fontSize: getWidth(22),
                                fontWeight: FontWeight.bold,
                                color: AppColor.skGrey,
                              ),
                        ),
                      )),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: getHeight(8)),
                    child: trailingChild,
                  ),
                ],
              );
  }
}
