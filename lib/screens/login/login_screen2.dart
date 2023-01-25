import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/screens/signup/signup_screen.dart';
import 'package:nearchat/ui/textfield.dart';
import 'package:nearchat/ui/theme/appcolors.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Stack(
              children: [
                Container(
                  // height: double.maxFinite,
                  // width: double.maxFinite,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColor.primaryColor,
                          AppColor.primaryColorL1,
                          AppColor.secondayColor,
                        ],
                        stops: [0.0, 0.7, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SvgPicture.asset(
                        "assets/svg/Social life-bro.svg",
                        height: 300,
                        width: 300,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50),
                              bottom: Radius.circular(0)),
                        ),
                        child: Container(
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
                                      final SvgParser parser = SvgParser();

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen()),
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
