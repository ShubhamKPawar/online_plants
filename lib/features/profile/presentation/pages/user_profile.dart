import 'package:flutter/material.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/form_field.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/core/utils/validation.dart';
import 'package:online_plants_app/features/login/presentation/widgets/login_fields.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  bool isEdit = false;

  TextEditingController userNameController =
      TextEditingController(text: 'Shubham Pawar');
  TextEditingController emailController =
      TextEditingController(text: 'shubhampawar@gmail.com');
  TextEditingController mobileNoController =
      TextEditingController(text: '9527280094');

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
          body: !isEdit ? _userProfile(context) : _editProfile(context),
        ),
      ),
    );
  }

  Widget _userProfile(BuildContext context) {
    return Column(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'profile_kUserProfile',
            child: CircleAvatar(
              radius: getHeight(60),
              backgroundImage: AssetImage(AppImages.kGoreshwarLogo),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getHeight(10),
              left: getWidth(30),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shubham Pawar',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge ??
                        TextStyle(
                          fontSize: getWidth(16),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'shubhampawar@gmail.com',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColor.skGrey) ??
                        TextStyle(
                          fontSize: getWidth(14),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(30))
            .copyWith(top: getHeight(30)),
        child: Column(
          children: [
            Container(
              height: getHeight(55),
              width: double.infinity,
              margin: EdgeInsets.only(top: getHeight(10)),
              padding: EdgeInsets.all(getHeight(8.0))
                  .copyWith(left: getWidth(10), right: getWidth(10)),
              decoration: BoxDecoration(
                color: AppColor.skGreenColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.skGreenColor.withOpacity(1),
                    blurStyle: BlurStyle.outer,
                    offset: Offset(1, 2),
                    spreadRadius: 0.8,
                    blurRadius: 0.4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColor.skGrey),
                  ),
                  Text(
                    'Shubham Pawar',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Container(
              height: getHeight(55),
              width: double.infinity,
              margin: EdgeInsets.only(top: getHeight(10)),
              padding: EdgeInsets.all(getHeight(8.0))
                  .copyWith(left: getWidth(10), right: getWidth(10)),
              decoration: BoxDecoration(
                color: AppColor.skGreenColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.skGreenColor.withOpacity(1),
                    blurStyle: BlurStyle.outer,
                    offset: Offset(1, 2),
                    spreadRadius: 0.8,
                    blurRadius: 0.4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Email',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColor.skGrey),
                  ),
                  Text(
                    'shubhampawar@gmail.com',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Container(
              height: getHeight(55),
              width: double.infinity,
              margin: EdgeInsets.only(top: getHeight(10)),
              padding: EdgeInsets.all(getHeight(8.0))
                  .copyWith(left: getWidth(10), right: getWidth(10)),
              decoration: BoxDecoration(
                color: AppColor.skGreenColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.skGreenColor.withOpacity(1),
                    blurStyle: BlurStyle.outer,
                    offset: Offset(1, 2),
                    spreadRadius: 0.8,
                    blurRadius: 0.4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Mobile No',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColor.skGrey),
                  ),
                  Text(
                    '9527280094',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _editProfile(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(getWidth(16.0)),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: getHeight(80),
                              backgroundImage:
                                  AssetImage(AppImages.kGoreshwarLogo),
                            ),
                            Positioned(
                              bottom: getHeight(0),
                              right: getHeight(10),
                              child: CircleAvatar(
                                backgroundColor: AppColor.skBlue,
                                radius: getHeight(25),
                                child: Icon(
                                  Icons.edit,
                                  size: getHeight(30),
                                  color: AppColor.skWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          'Edit photo',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: AppColor.skBlue,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(20),
                  ),
                  Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: getHeight(10),
                        ),
                        SizedBox(
                          width: getWidth(280),
                          child: UserNameField(
                              userNameController: userNameController),
                        ),
                        SizedBox(
                          height: getHeight(10),
                        ),
                        SizedBox(
                          width: getWidth(280),
                          child: EmailField(emailController: emailController),
                        ),
                        SizedBox(
                          height: getHeight(10),
                        ),
                        SizedBox(
                          width: getWidth(280),
                          child: MobileNumberField(
                              mobileNoController: mobileNoController),
                        ),
                        SizedBox(
                          height: getHeight(10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: getHeight(30.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getWidth(70.0)),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColor.skGreenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(getHeight(10)),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Update',
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget welcomeAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'My Profile',
      pinned: true,
      floating: true,
      trailingChild: GestureDetector(
        onTap: () {
          if (mounted) {
            setState(() {
              isEdit = !isEdit;
            });
          }
        },
        child: !isEdit
            ? Icon(
                Icons.edit,
                size: getHeight(30),
                color: AppColor.skGreenColor,
              )
            : Icon(
                Icons.info,
                size: getHeight(30),
                color: AppColor.skGreenColor,
              ),
      ),
    );
  }
}
