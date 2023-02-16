import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/screens/signup/signup_screen.dart';
import 'package:nearchat/services/auth_service.dart';
import 'package:nearchat/ui/textfield.dart';
import 'package:nearchat/ui/theme/appcolors.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = 'forgetPassword_screen';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();
  AuthService authService = AuthService();
  bool isClicked = false;
  bool _loader = false;
  Future<void> checkValues() async {
    setState(() {
      isClicked = true;
    });
    String email = emailcontroller.text.trim();
    if (email == "") {
      Fluttertoast.showToast(
        msg: "Please Fill all fields!!!",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(
        msg: "Invalid Email Address!",
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      setState(() {
        _loader = true;
      });
      await authService.forgetPassword(email);
      setState(() {
        _loader = false;
      });
    }
  }

  List<IconData> iconList = [
    Icons.people,
    Icons.settings,
    Icons.map,
  ];
  int _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
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
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: SvgPicture.asset(
                        "assets/svg/Forgot password-amico.svg"),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Forget Password?",
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "No problem! it's a common occurence. Please give us the email connected to your account",
                                style: TextStyle(fontSize: 13.sp),
                              ),
                              SizedBox(
                                height: 3.3.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldCustom(
                                    controller: emailcontroller,
                                    hint: "E-mail",
                                    onClick: isClicked,
                                    validation:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              _loader
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.primaryColor,
                                      ),
                                    )
                                  : Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Constants.screenWidth / 8),
                                      child: ElevatedButton(
                                        onPressed: checkValues,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColor.primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                25), // <-- Radius
                                          ),
                                        ),
                                        child: const Text(
                                          'Send Mail',
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 3.h,
                              ),
                            ],
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
}
