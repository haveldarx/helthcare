import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:medicalimagingapp/Widgets/Constants/constants.dart';
import 'package:medicalimagingapp/login/login.dart';
import 'package:medicalimagingapp/screens/homePage.dart';
import 'package:medicalimagingapp/widgets/generated.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ///Initializing SharedPreferences for retrieving date from local storage
  SharedPreferences? prefs;

  ///Functionality to check validation and retrieve String values from shared preferences
  ///Saving the state and check everytime when the app starts to maintain its state

  Future<bool> checkValidation() async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.containsKey('mailID') || prefs!.containsKey('AppleIDToken');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkValidation(),
      builder: (context, snapshot) {
        //Checks if user intro [snapshot] has data or not
        //if it does not return a FittedBox
        if (snapshot.hasData) {
          bool? intro = snapshot.data;
          return AnimatedSplashScreen(
            animationDuration: duration,
            backgroundColor: Themes.primary,
            splash: Image.asset(
              Assets.imagesSplash,
              height: 100,
              width: 100,
            ),
            nextScreen: intro == true ? const HomePage() : const AuthenticationScreen(),
            splashTransition: SplashTransition.slideTransition,
          );
        } else {
          return const FittedBox();
        }
      },
    );
  }
}
