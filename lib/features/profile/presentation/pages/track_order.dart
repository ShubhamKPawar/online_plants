import 'package:flutter/material.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/theme/theme_data/app_text_styles.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TrackOrder extends StatefulWidget {
  final String id;
  const TrackOrder({super.key, required this.id});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
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
          body: Container(
            margin: EdgeInsets.only(
              bottom: getHeight(12.0),
              top: getHeight(12.0),
              left: getWidth(16.0),
              right: getWidth(16.0),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.skWhite,
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withValues(alpha: 0.2), // Adjust opacity
                    offset: Offset(0, 2.5), // Move shadow in x and y directions
                    blurRadius: 4.0, // Increase blur for better visibility
                    spreadRadius: 2.5, // Increase spread
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getHeight(10.0),
                    right: getHeight(10.0),
                    top: getHeight(12.0),
                    bottom: getHeight(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Order#: 66323',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getHeight(5.0), bottom: getHeight(5.0)),
                  child: Divider(
                    thickness: getHeight(1.0),
                    height: getHeight(1.0),
                    color: AppColor.skGrey400,
                    endIndent: 0.2,
                    indent: 0.2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(10.00),
                    vertical: getHeight(10.00),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Marigold Plant',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: getHeight(6.0),
                                ),
                                Text.rich(
                                  TextSpan(
                                      text: '\u{20B9} ',
                                      style: Theme.of(context)
                                              .textTheme
                                              .labelLarge ??
                                          TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                      children: [
                                        TextSpan(
                                          text: '20/-',
                                          style: Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                      fontFamily: AppTextStyles
                                                          .numberFontFamily) ??
                                              TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              AppImages.kMarigold,
                              height: getHeight(70),
                              width: getWidth(80),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rating',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            width: getWidth(4.0),
                          ),
                          SizedBox(
                            height: getHeight(30),
                            width: getWidth(20) * 5,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, ratingIndex) {
                                  return Padding(
                                    padding: EdgeInsets.all(getHeight(2.0)),
                                    child: Icon(
                                      Icons.star_border_outlined,
                                      size: getHeight(20),
                                      color: AppColor.skOrange,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: getHeight(5.0), bottom: getHeight(5.0)),
                  child: Divider(
                    thickness: getHeight(1.0),
                    height: getHeight(1.0),
                    color: AppColor.skGrey400,
                    endIndent: 0.2,
                    indent: 0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getHeight(10.0),
                    right: getHeight(10.0),
                    top: getHeight(8.0),
                    bottom: getHeight(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Track Order',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up,
                        size: getHeight(35),
                        color: AppColor.skOrange,
                      ),
                    ],
                  ),
                ),
                Timeline.tileBuilder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  builder: TimelineTileBuilder.fromStyle(
                    contentsAlign: ContentsAlign.alternating,
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text('Timeline Event $index'),
                    ),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget welcomeSliverAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'Track Order',
      trailingChild: SizedBox.shrink(),
    );
  }
}
