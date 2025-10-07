import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/constants/dimensions.dart';
import 'package:online_plants_app/core/services_data/model/seller_model.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/form_field.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/core/utils/validation.dart';
import 'package:online_plants_app/features/login/presentation/widgets/login_fields.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class AdminProfile extends StatefulWidget {
  final bool fromAdmin;
  final SellerModel? sellerModel;
  const AdminProfile({
    super.key,
    required this.fromAdmin,
    required this.sellerModel,
  });

  @override
  State<AdminProfile> createState() => _AdminProfile();
}

class _AdminProfile extends State<AdminProfile> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController nurseryNameController = TextEditingController();

  bool isEdit = false;
  SellerModel? _sellerModel;
  bool fromAdmin = false;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage({required String? previousImageUrl}) async {
    if (_image == null) throw Exception('No image selected');

    // Compress image before uploading
    File? compressedImage = await _compressImage(_image!);
    if (compressedImage == null) throw Exception('Image compression failed');

    final ref = _storage.ref().child(
        'admin_image/${Constants.goreshwarId}/${DateTime.now().toIso8601String()}');

    // Delete the previous image if it exists
    if (previousImageUrl != null && previousImageUrl.isNotEmpty) {
      try {
        await _storage.refFromURL(previousImageUrl).delete();
      } catch (e) {
        print('Error deleting previous image: $e');
      }
    }

    // Upload the compressed image
    await ref.putFile(compressedImage);
    String downloadUrl = await ref.getDownloadURL();

    // Remove the original and compressed images after uploading
    try {
      await _image!.delete(); // Delete the original image
      await compressedImage.delete(); // Delete the compressed image
    } catch (e) {
      print('Error deleting images: $e');
    }

    return downloadUrl;
  }

  Future<File?> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        path.join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg');

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70, // Adjust quality (0 - 100, lower means more compression)
      format: CompressFormat.jpeg,
    );

    return result != null ? File(result.path) : null;
  }

  @override
  void initState() {
    if (widget.sellerModel != null) {
      _initData();
    } else {
      _sellerModel = null;
      fromAdmin = false;
    }
    super.initState();
  }

  void _initData() {
    fromAdmin = widget.fromAdmin;
    _sellerModel = widget.sellerModel;
    userNameController.text = _sellerModel?.name ?? '';
    emailController.text = _sellerModel?.email ?? '';
    mobileNoController.text = _sellerModel?.mobileNo ?? '';
    nurseryNameController.text = _sellerModel?.mainNurseryName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                welcomeAppBar(),
              ];
            },
            body: !isEdit ? _adminProfile(context) : _editProfile(context),
          ),
        ),
      ),
    );
  }

  Widget _adminProfile(BuildContext context) {
    return Column(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'AdminProfile',
            child: Stack(
              children: [
                // Placeholder or Error Image
                CircleAvatar(
                  radius: getHeight(60),
                  backgroundImage:
                      AssetImage(AppImages.kGoreshwarLogo), // Placeholder image
                ),
                // Cached Network Image
                CircleAvatar(
                  radius: getHeight(60),
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
                    _sellerModel?.mainNurseryName ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge ??
                        TextStyle(
                          fontSize: getWidth(16),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    _sellerModel?.email ?? '',
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
            _userDetails(
                context, 'Nursery Name', _sellerModel?.mainNurseryName ?? ''),
            SizedBox(
              height: getHeight(10),
            ),
            _userDetails(context, 'Name', _sellerModel?.name ?? ''),
            SizedBox(
              height: getHeight(10),
            ),
            _userDetails(context, 'Email', _sellerModel?.email ?? ''),
            SizedBox(
              height: getHeight(10),
            ),
            _userDetails(context, 'Mobile No', _sellerModel?.mobileNo ?? ''),
            SizedBox(
              height: getHeight(10),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (_sellerModel?.address ?? []).length,
                itemBuilder: (context, index) {
                  return Container();
                })
          ],
        ),
      ),
    ]);
  }

  Widget _userDetails(BuildContext context, String title, String text) {
    return Container(
      height: getHeight(55),
      width: double.infinity,
      margin: EdgeInsets.only(top: getHeight(10)),
      padding: EdgeInsets.all(getHeight(8.0))
          .copyWith(left: getWidth(10), right: getWidth(10)),
      decoration: BoxDecoration(
        color: AppColor.skGreenColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.skGreenColor.withValues(alpha: 1),
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
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColor.skGrey),
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
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
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(getWidth(16.0)),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              _image == null
                                  ? Stack(
                                      children: [
                                        // Placeholder or Error Image
                                        CircleAvatar(
                                          radius: getHeight(80),
                                          backgroundImage: AssetImage(AppImages
                                              .kGoreshwarLogo), // Placeholder image
                                        ),
                                        // Cached Network Image
                                        CircleAvatar(
                                          radius: getHeight(80),
                                          backgroundColor: Colors
                                              .transparent, // Ensure transparency for layering
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            _sellerModel?.imageUrl ?? '',
                                          ),
                                          onBackgroundImageError: (_, __) {},
                                        ),
                                      ],
                                    )
                                  : Image.file(_image!),
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
                          width: getWidth(280),
                          child: CustomTextField(
                              textController: nurseryNameController),
                        ),
                        SizedBox(
                          height: getHeight(10),
                        ),
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
                        SizedBox(
                          height: getHeight(10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: getHeight(30),
                    left: getWidth(60),
                    right: getWidth(60)),
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(
                      getWidth(180),
                      getHeight(50),
                    ),
                    backgroundColor: AppColor.skGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(getHeight(10)),
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
            ],
          ),
        ),
      );
    });
  }

  Widget welcomeAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: fromAdmin ? 'My Profile' : 'Nursery Profile',
      pinned: true,
      floating: true,
      trailingChild: fromAdmin
          ? GestureDetector(
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
            )
          : SizedBox.shrink(),
    );
  }
}
