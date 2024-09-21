import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_plants_app/core/constants/app_images.dart';
import 'package:online_plants_app/core/constants/constant.dart';
import 'package:online_plants_app/core/navigation/routes.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/clippers.dart';
import 'package:online_plants_app/core/utils/form_field.dart';
import 'package:online_plants_app/core/utils/util_data.dart';
import 'package:online_plants_app/core/utils/validation.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_cubit.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_cubit_bloc.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_event.dart';
import 'package:online_plants_app/features/login/presentation/bloc/Login_state.dart';
import 'package:online_plants_app/features/login/presentation/widgets/sign_in._help.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  List<CachedNetworkImage> imageUrls = [];
  late LoginBloc _loginBloc;
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late LoginCubit _loginCubit;

  bool isSignUp = false;

  //login controller
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
    _loginCubit = context.read<LoginCubit>();
    _pageController = PageController(initialPage: _currentIndex);
    fetchLoginImages();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void fetchLoginImages() {
    _loginBloc.add(LoginImageEvent());
  }

  void _startAutomaticPageChange() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (imageUrls.isNotEmpty) {
        _currentIndex = (_currentIndex + 1) % imageUrls.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _loginCubit.changeCurrentPage(_currentIndex);
      }
    });
  }

  bool _passVisible = false;
  @override
  Widget build(BuildContext context) {
    var bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Scaffold(
          appBar: null,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Top Container with PageView
              Stack(
                children: [
                  firstWave(),
                  BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                    if (state is LoginImageListState) {
                      setState(() {
                        isLoading = false;
                        imageUrls.addAll(
                          state.imagesList.map(
                            (e) => CachedNetworkImage(
                              imageUrl: e,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                AppImages.kMarigold,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.kMarigold,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                        imageUrls.shuffle(Random());
                      });
                      _startAutomaticPageChange();
                    }
                    if (state is FailureLoginState) {
                      isLoading = false;
                    }
                    if (state is LoadingState) {
                      isLoading = true;
                    }
                  }, builder: (context, state) {
                    return ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: HEIGHT * 0.28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              spreadRadius: 0.6,
                              blurRadius: 0.5,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: isLoading
                              ? pageViewImages(
                                  context,
                                  child: Image.asset(
                                    AppImages.kMarigold,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : PageView.builder(
                                  reverse: false,
                                  itemCount: imageUrls.length,
                                  controller: _pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  onPageChanged: (index) {
                                    _currentIndex = index;
                                    _loginCubit.changeCurrentPage(index);
                                  },
                                  itemBuilder: (context, index) {
                                    return pageViewImages(context,
                                        child: imageUrls[index]);
                                  },
                                ),
                        ),
                      ),
                    );
                  }),
                ],
              ),

              // Bottom Sheet that can be dragged up and down
              DraggableScrollableSheet(
                initialChildSize: 0.788,
                minChildSize: 0.788,
                maxChildSize: bottomInset > 0 ? 0.9 : 0.795,
                builder: (context, scrollController) {
                  return Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      ClipPath(
                        clipper: TopWaveClipper(),
                        child: Container(
                          padding: const EdgeInsets.only(top: 60),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColor.skWhite,
                          ),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              !isSignUp
                                  ? const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'WELCOME BACK',
                                          style: TextStyle(
                                              color: AppColor.skGreenColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Login to your Account',
                                          style: TextStyle(
                                              color: AppColor.skGreenColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  : const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'REGISTER',
                                          style: TextStyle(
                                              color: AppColor.skGreenColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Create your new account',
                                          style: TextStyle(
                                              color: AppColor.skGreenColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),

                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Form(
                                    key: key,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (isSignUp)
                                          SizedBox(
                                            width: 280,
                                            child: TextFormField(
                                              controller: userNameController,
                                              cursorColor:
                                                  AppColor.skGreenColor,
                                              cursorErrorColor:
                                                  AppColor.skGreenColor,
                                              style: const TextStyle(
                                                color: AppColor.skGreenColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.start,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              validator: (value) =>
                                                  usernameValidator(value),
                                              decoration: formFieldDecoration(
                                                hinText: 'Enter full name',
                                                prefixIcon: const Icon(
                                                  Icons.email,
                                                  size: 25,
                                                  color: AppColor.skGreenColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (isSignUp)
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        SizedBox(
                                          width: 280,
                                          child: TextFormField(
                                            controller: emailController,
                                            cursorColor: AppColor.skGreenColor,
                                            cursorErrorColor:
                                                AppColor.skGreenColor,
                                            style: const TextStyle(
                                              color: AppColor.skGreenColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.start,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) =>
                                                emailValidator(value),
                                            decoration: formFieldDecoration(
                                              hinText: 'Enter your email',
                                              prefixIcon: const Icon(
                                                Icons.email,
                                                size: 25,
                                                color: AppColor.skGreenColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 280,
                                          child: StatefulBuilder(
                                              builder: (context, setState) {
                                            return TextFormField(
                                              controller: passController,
                                              cursorColor:
                                                  AppColor.skGreenColor,
                                              cursorErrorColor:
                                                  AppColor.skGreenColor,
                                              style: const TextStyle(
                                                color: AppColor.skGreenColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.start,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              validator: (value) =>
                                                  passwordValidator(value),
                                              obscureText: _passVisible,
                                              obscuringCharacter: '*',
                                              decoration: formFieldDecoration(
                                                hinText: 'Password',
                                                prefixIcon: const Icon(
                                                  Icons.lock,
                                                  size: 25,
                                                  color: AppColor.skGreenColor,
                                                ),
                                                suffixIcon: GestureDetector(
                                                  onTap: () => setState(() =>
                                                      _passVisible =
                                                          !_passVisible),
                                                  child: Icon(
                                                    _passVisible
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    size: 25,
                                                    color:
                                                        AppColor.skGreenColor,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        if (!isSignUp)
                                          const SizedBox(
                                            width: 280,
                                            child: Align(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Text(
                                                'Forgot password?',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        if (!isSignUp)
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        SizedBox(
                                          width: 280,
                                          height: 40,
                                          child: MaterialButton(
                                            color: AppColor.skGreenColor,
                                            elevation: 2.0,
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            onPressed: () async {
                                              if (key.currentState!
                                                  .validate()) {
                                                if (!isSignUp) {
                                                  try {
                                                    UserCredential?
                                                        userCredential =
                                                        await userLogin(
                                                            email:
                                                                emailController
                                                                    .text
                                                                    .toString()
                                                                    .trim(),
                                                            password:
                                                                passController
                                                                    .text
                                                                    .toString()
                                                                    .trim());

                                                    USER_CREDENTIAL =
                                                        userCredential;
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                      context,
                                                      AppRoutes.dashboardRoute,
                                                      (route) => false,
                                                    );
                                                  } catch (e) {
                                                    showSnackbar(
                                                        context,
                                                        e.toString(),
                                                        Colors.red);
                                                  }
                                                } else {
                                                  try {
                                                    UserCredential?
                                                        userCredential =
                                                        await userRegister(
                                                            email: emailController
                                                                .text
                                                                .toString()
                                                                .trim(),
                                                            password:
                                                                passController
                                                                    .text
                                                                    .toString()
                                                                    .trim(),
                                                            userName:
                                                                userNameController
                                                                    .text
                                                                    .toString()
                                                                    .trim());

                                                    USER_CREDENTIAL =
                                                        userCredential;
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                      context,
                                                      AppRoutes.dashboardRoute,
                                                      (route) => false,
                                                    );
                                                  } on FirebaseException catch (e) {
                                                    showSnackbar(
                                                        context,
                                                        e.toString(),
                                                        Colors.red);
                                                  }
                                                }
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                !isSignUp ? 'Login' : 'Sign Up',
                                                style: const TextStyle(
                                                  color: AppColor.skWhite,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 280,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  AppImages.kGreenLine2),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 0.5,
                                          width: 120,
                                          decoration: const BoxDecoration(
                                              color: AppColor.skBlack),
                                        ),
                                        const Text(
                                          ' Or Continue With ',
                                          style: TextStyle(
                                              color: AppColor.skBlack,
                                              fontSize: 12),
                                        ),
                                        Container(
                                          height: 0.5,
                                          width: 120,
                                          decoration: const BoxDecoration(
                                              color: AppColor.skBlack),
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          try {
                                            await userSignInWithGoogle();
                                          } catch (e) {
                                            showSnackbar(context, e.toString(),
                                                Colors.red);
                                          }
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  AppImages.btnGoogle),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (Platform.isIOS) ...[
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            try {
                                              await userSignInApple();
                                            } catch (e) {
                                              showSnackbar(context,
                                                  e.toString(), Colors.red);
                                            }
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    AppImages.btnApple),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSignUp = !isSignUp;
                                        userNameController.clear();
                                        emailController.clear();
                                        passController.clear();
                                      });
                                    },
                                    child: Text.rich(
                                      TextSpan(
                                          text: !isSignUp
                                              ? 'Don\'t have account  '
                                              : 'Already have an account?  ',
                                          style: const TextStyle(
                                              color: AppColor.skBlack),
                                          children: [
                                            TextSpan(
                                                text: !isSignUp
                                                    ? 'Sign In'
                                                    : 'Login',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColor.skGreenColor))
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              //SKIP
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      hiveInstance?.setIsGuest(true);
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.dashboardRoute,
                                        (route) => false,
                                      );
                                    },
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'SKIP',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: AppColor.skGreenColor),
                                        ),
                                        Icon(
                                          Icons.navigate_next_sharp,
                                          color: AppColor.skGreenColor,
                                          size: 35,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Current Page Dot Viewer
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: BlocBuilder<LoginCubit, LoginCubitBloc>(
                            builder: (context, bloc) {
                          return SizedBox(
                            height: 12,
                            width: (10 * (imageUrls.length)).toDouble(),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: imageUrls.length,
                              itemBuilder: (context, index) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: bloc.currentPage == index ? 10 : 5,
                                  width: bloc.currentPage == index ? 10 : 5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.skGreenColor,
                                      width:
                                          bloc.currentPage == index ? 2 : 0.3,
                                    ),
                                    color: AppColor.skGreenColor,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 5,
                                );
                              },
                            ),
                          );
                        }),
                      ),

                      //Leaf 1 top left
                      Positioned(
                        top: HEIGHT * 0.15,
                        left: 0,
                        child: Transform.rotate(
                          angle: 120,
                          child: SizedBox(
                            height: 35,
                            child: Image.asset(AppImages.kLeaf1),
                          ),
                        ),
                      ),

                      //Leaf 1 right bottom
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Transform.rotate(
                          angle: 200,
                          child: SizedBox(
                            height: 35,
                            child: Image.asset(AppImages.kLeaf1),
                          ),
                        ),
                      ),

                      //Leaf 2 bottom left
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Transform.rotate(
                          angle: 120,
                          child: SizedBox(
                            height: 35,
                            child: Image.asset(AppImages.kLeaf2),
                          ),
                        ),
                      ),

                      //Leaf 2 top right
                      Positioned(
                        top: HEIGHT * 0.33,
                        right: 0,
                        child: Transform.rotate(
                          angle: -45,
                          child: SizedBox(
                            height: 35,
                            child: Image.asset(AppImages.kLeaf2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }

  Container pageViewImages(BuildContext context, {required Widget child}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.28,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.elliptical(4, 4)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            spreadRadius: 0.6,
            blurRadius: 0.5,
            color: Colors.grey.withOpacity(0.4),
          ),
        ],
      ),
      child: child,
    );
  }

  Opacity firstWave() {
    return Opacity(
      opacity: 0.2,
      child: ClipPath(
        clipper: WaveClipper(),
        child: Container(
          color: Colors.grey,
          width: WIDTH,
          height: HEIGHT * 0.288,
        ),
      ),
    );
  }
}
