import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

class Registration extends StatefulWidget {
  const Registration(
      {Key? key,  this.phoneNumber,  this.profileId})
      : super(key: key);
  final String? profileId;
  final String? phoneNumber;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool isUploading = false;
  var ppId = "";
  String profileUrl = "";
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _labelController = TextEditingController(text: "Home");
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _cityController = TextEditingController(text: "Bangaluru");
  final _pinCodeController = TextEditingController();
  final _addtionalInfoCntroller = TextEditingController();
  final imagePicker = ImagePicker();
  XFile? file;
  File? upfile;
  // LocationResult? locationResult;

  Future<String> uploadImageToFirebase(imageFile) async {
    String url = "";
    FirebaseStorage storage = FirebaseStorage.instance;
    ppId = Uuid().v4();
    Reference ref = storage.ref().child("images/$ppId");
    UploadTask uploadTask = ref.putFile(upfile!);
    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    print('this isss $url');
    return url;
  }

  uploadImage(userId) async {
    setState(() {
      isUploading = true;
    });
    String imageUrl = await uploadImageToFirebase(file);
    setState(() {
      isUploading = false;
      profileUrl = imageUrl;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Image Uploaded!"),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _labelController.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Registration",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                isUploading ? LinearProgressIndicator() : SizedBox.shrink(),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          child: ClipOval(
                            child: upfile != null
                                ? Image.file(
                                    upfile!,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    'images/userimage.jpg',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      Column(
                        children: [
                          RawMaterialButton(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.camera_outlined,
                              size: 24.0,
                              color: Colors.white,
                              semanticLabel: 'Camera',
                            ), //camera image

                            onPressed: () async {
                              file = await imagePicker.pickImage(
                                  source: ImageSource.camera);
                              if (file != null) {
                                setState(() {
                                  upfile = File(file!.path);
                                });
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          RawMaterialButton(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(15.0),

                            onPressed: () async {
                              file = await imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (file != null) {
                                setState(() {
                                  upfile = File(file!.path);
                                });
                              }
                            },
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 24.0,
                              semanticLabel: 'Gallery',
                              color: Colors.white,
                            ), //gallery image
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: 20),
                //uploading to firebase
                SizedBox(
                  width: size.width * 0.5,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: file != null
                        ? () {
                            uploadImage(widget.profileId);
                          }
                        : null,
                    child: Text(
                      "Upload Image ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),

                SizedBox(height: 20),

                TextFormField(
                    controller: _nameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Name*',
                      hintText: 'John Doe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please fill this field";
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Email*',
                      hintText: 'test@test.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please fill this field";
                      }
                      return null;
                    }),
                SizedBox(height: 20),

                SizedBox(
                  height: 40,
                  width: size.width * 0.5,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {},
                    icon: Icon(Icons.location_on),
                    label: Text("Mark Location"),
                  ),
                ),
                SizedBox(height: 20),

                Column(
                  children: [
                    TextFormField(
                        controller: _labelController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Address Label*',
                          hintText: 'Ex : Home',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please fill this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                        controller: _line1Controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Address Line 1*',
                          hintText: 'Flat Number, Building Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please fill this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                        controller: _line2Controller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Address Line 2*',
                          hintText: 'Locality, Road name/Landmark',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please fill this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                        controller: _cityController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'City*',
                          hintText: 'Ex : Banglore',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please fill this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                        controller: _pinCodeController,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Pin Code*',
                          hintText: 'Ex : 400004',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please fill this field";
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _addtionalInfoCntroller,
                      decoration: InputDecoration(
                        labelText: 'Additional info',
                        hintText: 'Ex : Near orion mall',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),

                Center(
                  child: Row(
                    children: [
                      SizedBox(width: 17),
                      SizedBox(
                        width: size.width * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Continue ",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          style: ElevatedButton.styleFrom(
                            // primary: mainThemeColor,
                            onPrimary: Colors.white24,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
    );
  }
}
