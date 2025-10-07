import 'package:flutter/material.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              welcomeAppBar(),
            ];
          },
          body: Column(
            children: [
              ...List.generate(
                5,
                (index) => Column(
                  children: [
                    Padding(padding: EdgeInsets.all(4)),
                    ListTile(
                      minLeadingWidth: 30,
                      trailing: Icon(Icons.notifications),
                      title: Text('fskhfhsfdgdgjdjgjjfds'),
                      subtitle: Text('wfrefrege'),
                    ),
                    Divider(
                      height: 1.0,
                    ),
                  ],
                ),
              ),
            ],
          )),
    ));
  }

  Widget welcomeAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'My Notification',
      pinned: true,
      floating: true,
    );
  }
}
