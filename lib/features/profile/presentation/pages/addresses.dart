import 'package:flutter/material.dart';
import 'package:online_plants_app/common/app_bar/app_bar_enum.dart';
import 'package:online_plants_app/common/app_bar/custom_app_bar.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/size.dart';

class Addresses extends StatefulWidget {
  const Addresses({super.key});
  @override
  State<Addresses> createState() => _AddressesState();
}

class _AddressesState extends State<Addresses> {
  bool addNewAddress = false;

  List addresses = [1, 2, 3];

  //Billing Address Details
  //First Name
  TextEditingController firstNameController = TextEditingController();

  //Last Name
  TextEditingController lastNameController = TextEditingController();

  //Country / Region
  TextEditingController countryNameController = TextEditingController();

  //Address First
  TextEditingController addressController = TextEditingController();
  TextEditingController addressIdController = TextEditingController();

  //Address Extra
  TextEditingController addressExtraController = TextEditingController();

  //Town / City Name
  TextEditingController townNameController = TextEditingController();

  //State Name
  TextEditingController stateNameController = TextEditingController();

  //Zip Code
  TextEditingController zipCodeController = TextEditingController();

  //Phone Number
  TextEditingController phoneNumController = TextEditingController();

  final _key = GlobalKey<FormState>();

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
          body: SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: getWidth(40.0))
                        .copyWith(top: 10.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.skGreenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(getHeight(10)),
                        ),
                      ),
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            addNewAddress = !addNewAddress;
                          });
                        }
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: getWidth(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColor.skWhite,
                            ),
                            Text(
                              'Add Address',
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
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColor.skWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]),
              ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: getHeight(10.0),
                    left: getWidth(8.0),
                    right: getWidth(8.0),
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getHeight(8.0),
                        horizontal: getWidth(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Banner(
                          message: 'default',
                          location: BannerLocation.topEnd,
                          color: AppColor.skAmber,
                          shadow: BoxShadow(
                            blurRadius: 0.3,
                            spreadRadius: 0.2,
                          ),
                          layoutDirection: TextDirection.ltr,
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColor.skWhite,
                                        fontSize: 13,
                                        height: 1.3,
                                      ) ??
                                  TextStyle(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getWidth(8.0),
                              vertical: getHeight(8.0),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.skGrey50.withOpacity(0.5),
                                      offset: Offset(getHeight(1), getWidth(1)),
                                      blurRadius: 0.3,
                                      spreadRadius: 0.2),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColor.skGreenColor,
                                  child: Center(
                                    child: Icon(
                                      Icons.home,
                                      color: AppColor.skWhite,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getWidth(8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        'My Home',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      SizedBox(
                                        height: 4.0,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Amalner tal: Newasa, dist: Ahilyanagar',
                                            maxLines: 3,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            'Maharashtra (MH)',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            'phone: 9527280094',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text(
                                            'pincode: 414105',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: EdgeInsets.only(
                  top: getHeight(10.0),
                  bottom: getHeight(10.0),
                  left: getWidth(12.0),
                  right: getWidth(12.0),
                ),
                child: addNewAddress || addresses.isEmpty
                    ? Form(
                        key: _key,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: getHeight(4.0),
                            ),
                            Text(
                              'Add New Address',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(
                              height: getHeight(4.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: inputField(context, 'First Name',
                                      firstNameController, validation: (value) {
                                    if ((value ?? '').isEmpty) {
                                      "${'First Name'} ${"is required"}";
                                    }
                                  }),
                                ),
                                SizedBox(width: getWidth(12.0)),
                                Expanded(
                                  child: inputField(
                                      context, 'Last Name', lastNameController,
                                      validation: (value) {
                                    if ((value ?? '').isEmpty) {
                                      "${'Last Name'} ${"is required"}";
                                    }
                                  }),
                                ),
                              ],
                            ),
                            inputField(
                                context, "${'Address'} 1", addressController,
                                validation: (value) {
                              if ((value ?? '').isEmpty &&
                                  (addressExtraController.text.isEmpty)) {
                                "${'Address 1'} ${"is required"}";
                              }
                            }),
                            inputField(context, 'Address Line 2',
                                addressExtraController,
                                validation: (value) {}, maxLines: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: inputField(
                                      context,
                                      '${'Town'} / ${'City'}',
                                      townNameController, validation: (value) {
                                    if ((value ?? '').isEmpty) {
                                      "${'Town'} / ${'City'} ${"is required"}";
                                    }
                                  }),
                                ),
                                SizedBox(width: getWidth(12.0)),
                                Expanded(
                                  child: inputField(
                                      context, 'State', stateNameController,
                                      validation: (value) {
                                    if ((value ?? '').isEmpty) {
                                      "${'State'} ${"is required"}";
                                    }
                                  }),
                                ),
                              ],
                            ),
                            inputField(context, '${'Country'} / ${'Region'}',
                                countryNameController, validation: (value) {
                              if ((value ?? '').isEmpty) {
                                "${'Country'} / ${'Region'} ${"is required"}";
                              }
                            }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: inputField(
                                      context, 'Zip Code', zipCodeController,
                                      textInputType: TextInputType.number,
                                      validation: (value) {
                                    if ((value ?? '').isEmpty) {
                                      "${'Zip Code'} ${"is required"}";
                                    }
                                  }, maxlength: 8),
                                ),
                                SizedBox(width: getWidth(12.0)),
                                Expanded(
                                  child: inputField(
                                      context, 'Phone', phoneNumController,
                                      textInputType: TextInputType.number,
                                      validation: (value) {
                                    if ((value ?? '').isEmpty) {
                                      "${'Phone'} ${"is required"}";
                                    }
                                  }, maxlength: 10),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: getHeight(30.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: getWidth(70.0)),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor:
                                              AppColor.skGreenColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                getHeight(10)),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          'Add Address',
                                          style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color:
                                                          AppColor.skWhite) ??
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
                      )
                    : SizedBox.shrink(),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget inputField(
      BuildContext context, String label, TextEditingController controller,
      {Function(String?)? validation,
      TextInputType? textInputType,
      int maxLines = 1,
      int? maxlength}) {
    return Padding(
      padding: EdgeInsets.only(top: getHeight(12), bottom: getHeight(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            validator: (value) => validation?.call(value),
            cursorErrorColor: Colors.black,
            cursorHeight: 14,
            cursorColor: Colors.black,
            maxLines: maxLines,
            keyboardType: textInputType,
            maxLength: maxlength,
            style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400) ??
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelStyle: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 16) ??
                  TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              labelText: label,
              labelStyle: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(fontSize: 16) ??
                  TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }

  String errorMessage = '';

  bool setErrorMessage(String message) {
    errorMessage = message;
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
    return false;
  }

  bool validateForm() {
    if (firstNameController.text.isEmpty) {
      return setErrorMessage("First name is required}");
    }
    if (lastNameController.text.isEmpty) {
      return setErrorMessage("Last Name is required");
    }
    if (countryNameController.text.isEmpty) {
      return setErrorMessage("Country /Region is required");
    }
    if (addressController.text.isEmpty && addressExtraController.text.isEmpty) {
      return setErrorMessage("Address is required");
    }
    if (townNameController.text.isEmpty) {
      return setErrorMessage("Town/City is required");
    }
    if (stateNameController.text.isEmpty) {
      return setErrorMessage("State is required");
    }
    if (zipCodeController.text.isEmpty) {
      return setErrorMessage("Zip Code is required");
    }
    if (phoneNumController.text.isEmpty) {
      return setErrorMessage("Phone is required");
    }
    if (phoneNumController.text.isEmpty ||
        phoneNumController.text.length < 10 ||
        !validatePhoneNumber(phoneNumController.text)) {
      return setErrorMessage("Invalid Phone Number");
    }
    return true;
  }

  bool validatePhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^[0-9]+$');
    return regex.hasMatch(phoneNumber);
  }

  Widget welcomeAppBar() {
    return CustomAppBar(
      appBarType: AppBarType.normal,
      title: 'My Addresses',
      pinned: true,
      floating: true,
    );
  }
}
