import 'dart:io';

// import 'package:advance_image_picker/advance_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

///GetxController to retrieve and store the user data on the firestore db
///
class DataController extends GetxController {
  late SharedPreferences prefs;
  FirebaseAuth auth = FirebaseAuth.instance;

  ///Stores results for doctor. initially is null when doctor review
  ///the applicant. Doc can update after analysing the user data
  String results = "";

  ///Stores retrieved shared_preferences value
  late String? email;

  bool patientStatus = true;

  ///Observable empty image list
  RxList patient = [].obs;

  RxList relative = [].obs;

  ///Observable empty image URLs list
  RxString valueURL = ''.obs;
  RxString valueURL2 = ''.obs;

  late String? doctorName;

  retrieveStringValue() async {
    prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("mailID");
    doctorName = prefs.getString("name");
    email = value;
  }

  ///Functionality to upload multiple Patient images to firebase storage
  // Future<String> uploadFile(
  //     String nameValue, List<ImageObject> images, String age) async {
  //   for (int i = 0; i < images.length; i++) {
  //     var imageFile = FirebaseStorage.instance
  //         .ref('$doctorName/Patients/${nameValue + age}/image $i');
  //     UploadTask task = imageFile.putFile(File(images[i].modifiedPath));
  //     TaskSnapshot snapshot = await task;
  //     var imgURl = await snapshot.ref.getDownloadURL();
  //     valueURL.value = imgURl;
  //     patient.add(valueURL.value.toString());
  //   }
  // }

  ///Functionality to upload multiple Relative images to firebase storage
  // Future<RxList> UploadRelativeImage(String doctorName, String nameValue,
  //     List<ImageObject> images2, String age) async {
  //   for (int i = 0; i < images2.length; i++) {
  //     var imageFile = FirebaseStorage.instance
  //         .ref('$doctorName/Relative/${nameValue + age}/image $i');
  //     UploadTask task = imageFile.putFile(File(images2[i].modifiedPath));
  //     TaskSnapshot snapshot = await task;
  //     var imgURl = await snapshot.ref.getDownloadURL();
  //     valueURL2.value = imgURl;
  //     relative.add(valueURL2.value.toString());
  //   }
  //   return relative;
  // }

  ///Functionality to collect all the user data in form of String, bool, int

  Future<void> userSetup(
      String patientName,
      String contact,
      String age,
      String country,
      String city,
      String state,
      String details,
      bool consumeTobacco,
      bool consumeAlcohol,
      bool consumeCigarette,
      String tobaccoYears,
      String cigaretteYears,
      String alcoholYears,
      int mouthPainTest,
      int threeFingerTest,
      String gender,
      // List<ImageObject> patientImages,
      // List<ImageObject> relativeImages,
      String time,
      String results) async {
    try {
      await retrieveStringValue();

      ///After getting all the info from the patient. upload images

      // await uploadFile(patientName, patientImages, age);

      DocumentReference ref = FirebaseFirestore.instance
          .collection('doctor')
          .doc(email)
          .collection('patientlist')
          .doc();

      FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(ref);
        if (!snapshot.exists) {
          ref.set({
            'RegistrationTime': time,
            'PatientName': patientName,
            'MobileNumber': contact,
            'Age': age,
            'Gender': gender.toString(),
            'Country': country,
            'State': state,
            'City': city,
            'ExtraDetails': details,
            'ConsumeTobacco': consumeTobacco,
            'ConsumeAlcohol': consumeAlcohol,
            'ConsumeCigarette': consumeCigarette,
            'PatientImages': patient,
            'TobaccoYears': tobaccoYears,
            'AlcoholYears': alcoholYears,
            'CigaretteYears': cigaretteYears,
            'OpeningMouthPainTest': mouthPainTest,
            'ThreeFingerTest': threeFingerTest,
            'RelativeImages': relative,
            'Results': results,
            'PatientStatus': patientStatus,
          });
          return true;
        }
        return true;
      });
    } catch (e) {
      // return false;
    }
  }
}

///Functionality to delete patient data from database
Future deleteData(String name) async {
  SharedPreferences prefs;
  try {
    prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("mailID");
    var snapshot = await FirebaseFirestore.instance
        .collection("doctor")
        .doc(value)
        .collection('patientlist')
        .where("RegistrationTime", isEqualTo: name)
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  } catch (e) {
    return false;
  }
}

///Functionality to login user from email and password
Future<bool> login(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    // print(e);
    return false;
  }
}
