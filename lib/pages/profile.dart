import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:foodshop/pages/login.dart';
import 'package:foodshop/pages/signup.dart';
import 'package:foodshop/service/auth.dart';
import 'package:foodshop/service/shared_pref.dart';
import 'package:foodshop/splashscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? profile, name, email;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<void> getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {
      uploadItem();
    });
  }

  uploadItem() async* {
    if (selectedImage != null) {
      String addId = randomAlphaNumeric(10); // Add data to Firebase Storage

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);

      // Start the upload task
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      // Get the download URL
      var downloadUrl = await (await task).ref.getDownloadURL();
      await SharedPreferenceHelper().saveUserProfile(downloadUrl);
      setState(() {});
    }
  }

  getthesharedpre() async {
    profile = await SharedPreferenceHelper().getUserProfile();
    name = await SharedPreferenceHelper().getUserName();
    email = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  onthisload() async {
    await getthesharedpre();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onthisload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:name==null? CircularProgressIndicator(): SingleChildScrollView(
          child: Container(
              child: Column(
                children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 45.0,
                  left: 20.0,
                  right: 20.0,
                ),
                height: MediaQuery.of(context).size.height / 4.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110),
                    )),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 6.5),
                  child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(60.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: selectedImage==null?
                        GestureDetector(
                          onTap:(){
                            getImage();
                          },
                          child:profile==null?Icon(Icons.person, size: 100, color: Colors.grey,):Image.network(
                            profile!,
                              height: 120, width:120 , fit: BoxFit.cover)
                        ):
                        Image.file(selectedImage!,height:120,width:120,fit:BoxFit.cover),
                      )),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name!,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(children: [
                        Icon(Icons.person, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                name!,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ])
                      ])))),
          SizedBox(
            height: 20.0,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(children: [
                        Icon(Icons.email, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                email!,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ])
                      ])))),
          SizedBox(
            height: 20.0,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(children: [
                        Icon(Icons.description, color: Colors.black),
                        SizedBox(width: 20.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Terms and Condition',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent),
                              ),
                            ])
                      ])))),
          SizedBox(
            height: 20.0,
          ),GestureDetector(
  onTap: () async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator( strokeWidth: 5.0,
            color: Colors.lightGreen[300],),
        );
      },
    );

    // lete operation
    await AuthMethods().deleteuser();

    // Delay for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    
    Navigator.pop(context);

    // Navigate to signup page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Signup()),
    );
  },
  child: Container(
    margin: EdgeInsets.symmetric(horizontal: 20.0),
    child: Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.black),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: ()async {
              await AuthMethods().SignOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginIn()));
              
              },
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(children: [
                          Icon(Icons.logout, color: Colors.black),
                          SizedBox(width: 20.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LogOut',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ])
                        ])))),
          ),
                ],
              )),
        ));
  }
}
