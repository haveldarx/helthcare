import 'dart:io';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:medicalimagingapp/controller/authentication_controller.dart';
import 'package:medicalimagingapp/widgets/generated.dart';
import 'package:medicalimagingapp/widgets/widgets/spaces.dart';



class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TapGestureRecognizer? _tapGestureRecognizer;

  @override
  void initState() {
    //for checking internet connectivity
    controller.checkInternetConnection();
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _handlePress;
  }

  ///disposing tap gesture recognizer
  @override
  void dispose() {
    _tapGestureRecognizer!.dispose();
    super.dispose();
  }

  ///Functionality to vibrate on pressed
  void _handlePress() {
    HapticFeedback.vibrate();
  }

  ///Initialing GetxController as controller
  final AuthenticationController controller =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                'assets/34.png'
                ),
                // Lottie.asset("assets/lottie/auth.json",
                //     height: 200, width: 200),
                // const CustomTextStyle(
                //   text: StringConst.APP_SUBTITLE,
                //   fontWeight: FontWeight.w700,
                // ),
                DividerSpace(),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SignInButton(Buttons.Google, onPressed: () {
                      controller.googleSignInMethod();
                    }),
                    
                    Platform.isIOS
                        ? SignInButton(
                            Buttons.AppleDark,
                            onPressed: () async {
                              controller.appleSignIn();
                            },
                          )
                        : FittedBox()
                  ],
                ),

                // RichText(
                //   text: TextSpan(
                //     text: StringConst.COMPANY_POLICY,
                //     style: const TextStyle(
                //         color: Themes.secondary,
                //         fontSize: 12
                //     ),
                //     children: [
                //       TextSpan(
                //           recognizer: _tapGestureRecognizer,
                //           text: "Data Use Policy",
                //           style: const TextStyle(
                //               decoration: TextDecoration.underline,
                //               color: Themes.primary
                //           )
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
