import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/screens/login/login_screen.dart';
import 'package:nearchat/screens/signup/signup_screen.dart';
import 'package:nearchat/ui/theme/appcolors.dart';
import 'package:sizer/sizer.dart';

import '../ui/textfield.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = 'start_screen';

  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: AppColor.primaryColor,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          child: SizedBox(
            height: Constants.screenHeight,
            width: Constants.screenWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: Constants.screenWidth,
                minHeight: Constants.screenHeight,
              ),
              child: Stack(
                children: [
                  Container(
                    // height: double.maxFinite,
                    // width: double.maxFinite,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primaryColorD1,
                          AppColor.primaryColorD0,
                          AppColor.primaryColor,
                          AppColor.primaryColorL1,
                          AppColor.mixColor,
                          AppColor.secondayColor,
                          // AppColor.primaryColorlight,
                        ],
                      ),
                    ),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/Online world-bro.svg",
                      ),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: Constants.screenWidth / 13),
                        child: Text(
                          "Chat with confidence, connect with comfort, and be yourself. Make every chat a new adventure",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.5.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.screenWidth / 7),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(25), // <-- Radius
                                ),
                              ),
                              child: const Text(
                                'Login',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.screenWidth / 7),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignUpScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.circular(25), // <-- Radius
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
