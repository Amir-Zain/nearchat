import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/screens/forget-password/forgetPassword_screen.dart';
import 'package:nearchat/screens/home/home_screen.dart';
import 'package:nearchat/screens/signup/signup_screen.dart';
import 'package:nearchat/services/auth_service.dart';
import 'package:nearchat/ui/textfield.dart';
import 'package:nearchat/ui/theme/appcolors.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loader = false;
  bool isClicked = false;
  AuthService authService = AuthService();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Future<void> checkValues(BuildContext context) async {
    setState(() {
      isClicked = true;
    });
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    if (password == "" || email == "") {
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
      var status = await authService.login(email, password);
      setState(() {
        _loader = false;
      });

      if (status == 'Success') {
        if (!mounted) return;
        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      }
    }
  }

  chageObscured() {
    setState(() {
      isObscured = !isObscured;
    });
  }

  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
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
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    flex: 6,
                    child: SvgPicture.asset("assets/svg/Social life-bro.svg"),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 22),
                          child: Column(
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 19.sp,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldCustom(
                                    hint: "E-mail",
                                    controller: emailcontroller,
                                    validation:
                                        AutovalidateMode.onUserInteraction,
                                    onClick: isClicked,
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  TextFieldCustom(
                                    hint: "Password",
                                    controller: passwordcontroller,
                                    obscured: isObscured,
                                    notifyParentIconCLicl: chageObscured,
                                    icon: isObscured
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                ForgetPasswordScreen.routeName);
                                          },
                                          child: const Text(
                                            'Forget Password?',
                                            style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              _loader
                                  ? const CircularProgressIndicator(
                                      color: AppColor.primaryColor,
                                    )
                                  : Container(
                                      width: double.maxFinite,
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Constants.screenWidth / 8),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (!mounted) return;
                                          checkValues(context);
                                        },
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
                                          'Login',
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an Acount?',
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SignUpScreen.routeName);
                                    },
                                    child: const Text(
                                      ' Sign Up',
                                      style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              )
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
