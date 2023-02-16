import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/models/user_model.dart';
import 'package:nearchat/screens/login/login_screen.dart';
import 'package:nearchat/services/auth_service.dart';
import 'package:nearchat/ui/textfield.dart';
import 'package:nearchat/ui/theme/appcolors.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signUp_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _loader = false;
  bool isClicked = false;
  AuthService authService = AuthService();
  Future<void> checkValues() async {
    setState(() {
      isClicked = true;
    });
    String email = emailcontroller.text.trim();
    String name = namecontroller.text.trim();
    String password = passwordcontroller.text.trim();
    if (name == "" || password == "" || email == "") {
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
      await authService.signup(email, password, name);
      setState(() {
        _loader = false;
      });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics:
            const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
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
                  flex: 5,
                  child: SvgPicture.asset("assets/svg/Messaging-pana.svg"),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.maxFinite,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50), bottom: Radius.circular(0)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 22),
                      child: Column(
                        children: [
                          Text(
                            "Sign up",
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
                                hint: "Name",
                                controller: namecontroller,
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              TextFieldCustom(
                                hint: "E-mail",
                                controller: emailcontroller,
                                validation: AutovalidateMode.onUserInteraction,
                                onClick: isClicked,
                              ),
                              SizedBox(
                                height: 3 * Constants.blockSizeVertical,
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
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          _loader
                              ? const CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                )
                              : Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Constants.screenWidth / 8),
                                  child: ElevatedButton(
                                    onPressed: checkValues,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            25), // <-- Radius
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign Up',
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
                                'Already have an Acount?',
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, LoginScreen.routeName);
                                },
                                child: const Text(
                                  '  Log in',
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
