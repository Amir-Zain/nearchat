import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/screens/clipper_screen.dart';
import 'package:nearchat/screens/login/login_screen2.dart';
import 'package:nearchat/screens/signup/signup_screen.dart';
import 'package:nearchat/ui/textfield.dart';
import 'package:nearchat/ui/theme/appcolors.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
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
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    flex: 6,
                    child: Center(
                      child: SvgPicture.asset("assets/svg/Social life-bro.svg"),
                    ),
                  ),
                  Expanded(
                    flex: 6,
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
                                  fontSize: 3 * Constants.blockSizeVertical,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 6 * Constants.blockSizeVertical,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldCustom(
                                    hint: "E-mail",
                                  ),
                                  SizedBox(
                                    height: 3 * Constants.blockSizeVertical,
                                  ),
                                  TextFieldCustom(
                                    hint: "Password",
                                    icon: Icons.visibility,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3 * Constants.blockSizeVertical,
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants.screenWidth / 10),
                                child: ElevatedButton(
                                  onPressed: () {},
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
                                    'Login',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4 * Constants.blockSizeVertical,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an Acount?',
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen2()),
                                      );
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
