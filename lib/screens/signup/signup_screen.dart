import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nearchat/constants.dart';
import 'package:nearchat/screens/login/login_screen.dart';
import 'package:nearchat/screens/login/login_screen2.dart';
import 'package:nearchat/ui/textfield.dart';
import 'package:nearchat/ui/theme/appcolors.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signUp_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  height: 30,
                ),
                Expanded(
                    flex: 5,
                    child: SvgPicture.asset("assets/svg/Messaging-pana.svg")),
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
                              fontSize: 3 * Constants.blockSizeVertical,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 4 * Constants.blockSizeVertical,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldCustom(
                                hint: "Name",
                              ),
                              SizedBox(
                                height: 3 * Constants.blockSizeVertical,
                              ),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(25), // <-- Radius
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3 * Constants.blockSizeVertical,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an Acount?',
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
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
