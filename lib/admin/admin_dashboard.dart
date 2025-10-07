import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_bloc.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_event.dart';
import 'package:online_plants_app/core/services_data/seller_info_bloc/seller_info_state.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late SellerInfoBloc _sellerInfoBloc;
  @override
  void initState() {
    super.initState();

    _sellerInfoBloc = context.read<SellerInfoBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sellerInfoBloc.add(GetSellerInfoEvent(Constants.goreshwarId));
  }

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
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(40), vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.adminAddCategory);
                            },
                            child: Text(
                              'Add Category',
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
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(40), vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.adminAddPlant);
                            },
                            child: Text(
                              'Add Plants',
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
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidth(40), vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Go To Main Screen',
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
                  ),
                ],
              ),
            ),
          ),
        ),
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
        automaticallyImplyLeading: false,
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
        callback: () {
          if (_sellerModel != null) {
            Navigator.of(context).pushNamed(
              AppRoutes.adminProfile,
              arguments: {'fromAdmin': true, 'seller': _sellerModel!},
            );
          }
        },
      );
    });
  }
}
