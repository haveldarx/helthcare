import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicalimagingapp/login/login.dart';
import 'package:medicalimagingapp/screens/homePage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';



///Getx Controller from Get [package] controls all the authentication
///Gets all the user credentials from google_sign_in [package] amd Firebaseauth

class AuthenticationController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  ///Storing _googlesignin from Google sign in constructor

  GoogleSignIn _googlesignin = GoogleSignIn();

 late SharedPreferences prefs;

  RxBool  hasInternet = false.obs;

  ConnectivityResult connectivityResult = ConnectivityResult.none;

  /// storing variables from classes that comes from Google sign in [package]
  ///
  ///The State only changes if the value change
  ///We use Rx because To make it observable. also it can be null

  var googleSignUser ;
  var authCredential;

  var appleUser ;

  ///Functionality that helps to sign in to google account
  ///Initializes SharedPreferences from shared_preferences [package] for persisting the state of the app
  ///

 late StreamSubscription internetSubscription;

  ///Check the internet Connectivity and shows the simple overlay
  checkInternetConnection() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      this.hasInternet.value = hasInternet;
      hasInternet
          ? null
          : showSimpleNotification(
              const Text(
                "No Internet connection",
              ),
              background: Colors.red.shade800);
    });
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  /// Google Sign in method
  googleSignInMethod() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
    hasInternet.value
        ? null
        : showSimpleNotification(const Text("No Internet Connection"),
            background: Colors.red.shade700);

     GoogleSignInAccount? googleSignInAccount = await _googlesignin.signIn();
       

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    prefs = await SharedPreferences.getInstance();
  prefs.setString("name", googleSignInAccount!.displayName.toString());
    prefs.setString("mailID", googleSignInAccount.email);
    prefs.setString("ProfileURL", googleSignInAccount.photoUrl.toString());

    ///Calls user setup function after signing in and sets up the user in the database
    // await userSetup();

    ///Checks if user is null or not
    ///
    try {
      if (googleSignInAccount== null) {
        Get.to(() => const AuthenticationScreen());
      } else {
        Get.offAll(() => const HomePage());
      }
    } catch (e) {
      // print(e);
    }
  }

  ///apple sign in method
  appleSignIn() async {
    hasInternet.value = await InternetConnectionChecker().hasConnection;
    hasInternet.value
        ? null
        : showSimpleNotification(const Text("No Internet Connection"),
            background: Colors.red.shade700);

    if (hasInternet.value) {
      appleUser.value = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider("apple.com");
      final credential = oAuthProvider.credential(
          idToken: appleUser.value.identityToken,
          accessToken: appleUser.value.authorizationCode);

      final UserCredential appleUserCredential =
          await auth.signInWithCredential(credential);
          String? mailID = appleUserCredential.user!.email;
      prefs = await SharedPreferences.getInstance();
      prefs.setString("AppleIDToken", appleUser.value.identityToken);
      prefs.setString("mailID",mailID! );
      prefs.setString(
          "name", appleUserCredential.user!.displayName!.toUpperCase());

      String? email = appleUserCredential.user!.email;
      String? displayName = appleUserCredential.user!.displayName;
      String? uid = appleUserCredential.user!.uid;
      DateTime dateTime = DateTime.now();

      CollectionReference users = FirebaseFirestore.instance
          .collection('doctor')
          .doc(email)
          .collection('doctordetails');

      users.add({
        'ID': uid,
        'LoginTime': dateTime,
        'Name': displayName,
        'E-mail': email
      });

      try {
        if (appleUser.value != null) {
          Get.off(() => const HomePage());
        } else {
          Get.to(() => const AuthenticationScreen());
        }
      } catch (e) {
        print(e);
      }
    } else {
      null;
    }
  }

  ///logout method
  logout() async {
    await auth.signOut();
    prefs = await SharedPreferences.getInstance();
    prefs.remove('AppleIDToken');
    prefs.remove('name');
    prefs.remove('mailID');
    prefs.remove('GUsername');
    prefs.remove("ProfileURL");

    if (auth.currentUser == null) {
      Get.off(() => const AuthenticationScreen());
    } else {
      Get.to(() => const HomePage());
    }
  }

  ///Functionality for Setting users up in the Firestore database amd collecting their uid,
  ///displayName and email from their google account

  Future<void> userSetup() async {
    ///Storing information in Strings from the signed in user.
    String uid = _googlesignin.currentUser!.id;
    String displayName = googleSignUser.value.displayName.capitalizeFirst;
    String email = googleSignUser.value.email;
    DateTime dateTime = DateTime.now();

    CollectionReference users = FirebaseFirestore.instance
        .collection('doctor')
        .doc(email)
        .collection('doctordetails');

    users.add({
      'ID': uid,
      'LoginTime': dateTime,
      'Name': displayName,
      'E-mail': email
    });
  }
}
