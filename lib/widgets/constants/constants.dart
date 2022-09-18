import 'package:flutter/material.dart';

// const primaryColor = Colors.transparent;
// const KInputDecoration = InputDecoration(labelText: "Enter your Name");
const kInputDecorationUserName = InputDecoration(
  prefixIcon: Icon(
    Icons.account_circle_rounded,
    color: Colors.black45,
  ),
  labelText: 'Patient Name',
  labelStyle: TextStyle(
    color: Colors.black45,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kEnterDecorationUserName = InputDecoration(
  prefixIcon: Icon(
    Icons.account_circle_rounded,
    color: Colors.black45,
  ),
  labelText: 'Enter Patient Name',
  labelStyle: TextStyle(
    color: Colors.black45,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kInputDecorationAge = InputDecoration(
  prefixIcon: Icon(
    Icons.boy_rounded,
    color: Colors.black45,
  ),
  labelText: "Patient's Age",
  labelStyle: TextStyle(
    color: Colors.black45,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kInputDecorationPhoneNumber = InputDecoration(
  labelText: 'Phone Number',
  floatingLabelStyle: TextStyle(color: Colors.black45),
  counterText: "",
  labelStyle: TextStyle(
    color: Colors.black45,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kInputDecorationDetails = InputDecoration(
  helperMaxLines: 10,
  helperText: "Please Mention some extra details",
  labelText: 'Enter More Details',
  labelStyle: TextStyle(
    color: Colors.black45,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

class Themes {
  static const Color theme = Color(0xff233974);
  static const Color background = Color(0xffffffff);
  static const Color text = Color(0xffa8a9b1);
  static const Color heading = Color(0xff27283c);
  static const Color primary = Color(0xff233974);
  static const Color secondary = Colors.grey;
}

const colorTextStyle = TextStyle(
    fontFamily: 'Horizon',
    letterSpacing: 0.6,
    wordSpacing: 0.5,
    fontWeight: FontWeight.w500);

const colorTextStyle2 = TextStyle(
    fontFamily: 'Horizon',
    letterSpacing: 0.6,
    wordSpacing: 0.5,
    color: Themes.background,
    fontWeight: FontWeight.w500);

const headingStyle = TextStyle(
    color: Colors.white,
    fontSize: 21.5,
    height: 1.4,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.6,
    wordSpacing: 0.5);

const subheadingStyle = TextStyle(
    color: Themes.heading,
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
    wordSpacing: 0.5);

const alert = TextStyle(fontSize: 15, fontWeight: FontWeight.w300);

const padding = EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0);


//Duration
const duration = Duration(milliseconds: 10);

const pageTransitionDuration = Duration(milliseconds: 200);

const formSubmitDuration = Duration(seconds: 1);



const height5 = SizedBox( height: 5, );
const height10 = SizedBox( height: 10, );
const height20 = SizedBox( height: 20, );
const height30 = SizedBox( height: 30, );
const height40 = SizedBox( height: 40, );
const height80 = SizedBox( height: 80, );
const height200 = SizedBox( height: 200, );
const width15 = SizedBox( width: 15 );
const width20 = SizedBox( width: 20, );
const width10 = SizedBox( width: 10, );

const padding12 = EdgeInsets.all(12);
const padding15 = EdgeInsets.all(15);
const padding18 = EdgeInsets.all(18);
const padding120 = EdgeInsets.all(20);


const boxDecorationImages = BoxDecoration(

    color: Colors.white,
);

//
const formPadding = EdgeInsets.only(
left: 50,
right: 50,
bottom: 30,
);

const formPadding2 = EdgeInsets.only(
  left: 35,
  right: 35,

);
const formPadding3 = EdgeInsets.only(
  left: 50,
  right: 50,
  top: 30,
);
