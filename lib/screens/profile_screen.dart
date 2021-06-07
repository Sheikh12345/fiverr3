import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deto/widgets/drawer.dart';
import 'package:deto/widgets/home_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../sizes_helpers.dart';

class ProfileScreen extends StatefulWidget {
  final username;
  const ProfileScreen({Key key, this.username}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controllerPersonalInfo = TextEditingController();

  bool drawerCanOpen = true;
  CollectionReference _reference =
      FirebaseFirestore.instance.collection("Users");
  resetApp() {
    setState(() {
      drawerCanOpen = false;
    });
  }

  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore _ref = FirebaseFirestore.instance;

  final imagePicker = ImagePicker();
  File imageFile1;
  var imagePath1;
  var image1;

  String fileName;
  firebase_storage.Reference ref1;

  static CollectionReference _fireRefUsers =
      FirebaseFirestore.instance.collection("Users");

  Future getImage() async {
    image1 = await imagePicker.getImage(
        preferredCameraDevice: CameraDevice.front, source: ImageSource.gallery);
    setState(() {
      imagePath1 = image1.path;
      imageFile1 = File(image1.path);
    });
  }

  String _profileUrl;

  @override
  void initState() {
    super.initState();
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("${FirebaseAuth.instance.currentUser.uid}")
        .getDownloadURL()
        .then((value) {
      setState(() {
        _profileUrl = value;
      });
    });

    _reference.doc(FirebaseAuth.instance.currentUser.uid).get().then((value) {
      _controllerPersonalInfo.text = "${value.get("personalInfo")}";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          key: scaffoldKey,
          endDrawer: AppDrawer(),
          body: SingleChildScrollView(
            child: StreamBuilder(
              stream: _reference
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper:
                                  WaveClipperTwo(flip: false, reverse: false),
                              child: Container(
                                height: displayHeight(context) * 0.35,
                                color: Color(0xff0d0d0d),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 5, right: 20),
                                    child: Row(
                                      children: [
                                        DefaultTextStyle(
                                          style: const TextStyle(
                                              fontFamily: 'Storopia',
                                              fontSize: 15.0,
                                              color: Colors.white),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              WavyAnimatedText('DETO'),
                                            ],
                                            isRepeatingAnimation: false,
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                            onTap: () {
                                              scaffoldKey.currentState
                                                  .openEndDrawer();
                                            },
                                            child: Icon(
                                              Icons.menu,
                                              color: Colors.blue,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Demokratischer Event-Teriminkalender und Organizer',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontFamily: 'Storopia'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.04,
                                                top: size.height * 0.03),
                                            width: size.width * 0.38,
                                            height: size.width * 0.38,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageFile1 != null
                                                      ? FileImage(imageFile1)
                                                      : _profileUrl != null
                                                          ? NetworkImage(
                                                              _profileUrl)
                                                          : AssetImage(
                                                              "images/logo.png"),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.1,
                                            height: size.width * 0.1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              onPressed: () {
                                                getImage();
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: Colors.blue[700],
                                                size: size.width * 0.065,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.04,
                                          ),
                                          Text(
                                            "WILLKOMMEN",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: size.width * 0.04),
                                          ),
                                          Text(
                                            "${snapshot.data["name"].toString().toUpperCase()}",
                                            style: GoogleFonts.roboto(
                                                color: Colors.yellow[700],
                                                fontSize: size.width * 0.04),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: size.height * 0.015),
                              width: size.width,
                              height: size.height * 0.03,
                              color: Colors.black,
                              child: Text(
                                "YOUR PUBLIC PROFILE INFO",
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black87, width: 0.6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "USERNAME:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "${snapshot.data['name']}",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black87, width: 0.6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "PASSWORD :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "*********",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black87, width: 0.6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "E-MAIL :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "${FirebaseAuth.instance.currentUser.email}",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black38, width: 0.4)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TELEGRAM :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "T.ME/CHAT",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: size.width,
                              height: size.height * 0.03,
                              color: Colors.black,
                              child: Text(
                                "SOME PERSONAL INFO FOR PUBLIC PROFILE",
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 0,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.2,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          color: Colors.black45, width: 1))),
                              child: TextField(
                                controller: _controllerPersonalInfo,
                                decoration: InputDecoration(
                                    hintStyle: GoogleFonts.cabin(
                                        fontSize: size.width * 0.03,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    border: InputBorder.none,
                                    hintText:
                                        "HERE YOU CAN WRITE SOME STUFF FOR YOUR PUBLIC PROFILE..."),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          uploadImageToFireStore(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          width: size.width,
                          height: size.height * 0.06,
                          color: Colors.black,
                          child: Text(
                            "SAVE CHANGES",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top: size.height * 0.01),
                          alignment: Alignment.center,
                          width: size.width,
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    print("kasif");
                                    _showMyDialog(context,size);
                                  },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red[600],
                                    size: size.width * 0.1,
                                  )),
                              Text(
                                "DELETE PROFILE",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.025),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper:
                                  WaveClipperTwo(flip: false, reverse: false),
                              child: Container(
                                height: displayHeight(context) * 0.35,
                                color: Color(0xff0d0d0d),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 5, right: 20),
                                    child: Row(
                                      children: [
                                        DefaultTextStyle(
                                          style: const TextStyle(
                                              fontFamily: 'Storopia',
                                              fontSize: 15.0,
                                              color: Colors.white),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              WavyAnimatedText('DETO'),
                                            ],
                                            isRepeatingAnimation: false,
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                            onTap: () {
                                              print("kashif");
                                              scaffoldKey.currentState
                                                  .openEndDrawer();
                                            },
                                            child: Icon(
                                              Icons.menu,
                                              color: Colors.blue,
                                              size: 30,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'Demokratischer Event-Teriminkalender und Organizer',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 8,
                                              fontFamily: 'Storopia'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: size.width * 0.04,
                                                top: size.height * 0.03),
                                            width: size.width * 0.38,
                                            height: size.width * 0.38,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: imageFile1 != null
                                                      ? FileImage(imageFile1)
                                                      : AssetImage(
                                                          "images/logo.png"),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          Container(
                                            width: size.width * 0.1,
                                            height: size.width * 0.1,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              onPressed: () {
                                                getImage();
                                              },
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: Colors.blue[700],
                                                size: size.width * 0.065,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      StreamBuilder(
                                          stream: _reference
                                              .doc(FirebaseAuth
                                                  .instance.currentUser.uid)
                                              .snapshots(),
                                          builder: (_, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: size.height * 0.04,
                                                  ),
                                                  Text(
                                                    "WILLKOMMEN",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 0.04),
                                                  ),
                                                  Text(
                                                    "${snapshot.data["name"].toString().toUpperCase()}",
                                                    style: GoogleFonts.roboto(
                                                        color:
                                                            Colors.yellow[700],
                                                        fontSize:
                                                            size.width * 0.04),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Column(
                                                children: [
                                                  SizedBox(
                                                    height: size.height * 0.04,
                                                  ),
                                                  Text(
                                                    "WILLKOMMEN",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 0.04),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 0.04),
                                                  ),
                                                ],
                                              );
                                            }
                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: size.height * 0.015),
                              width: size.width,
                              height: size.height * 0.03,
                              color: Colors.black,
                              child: Text(
                                "YOUR PUBLIC PROFILE INFO",
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black87, width: 0.6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "USERNAME:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "Kashif",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black87, width: 0.6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "PASSWORD :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "*********",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black87, width: 0.6)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "E-MAIL :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "${FirebaseAuth.instance.currentUser.email}",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black38, width: 0.4)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.04,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TELEGRAM :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.036),
                                  ),
                                  Text(
                                    "T.ME/CHAT",
                                    style: GoogleFonts.cabin(
                                        color: Colors.blue[600],
                                        fontWeight: FontWeight.w600,
                                        fontSize: size.width * 0.04),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: size.width,
                              height: size.height * 0.03,
                              color: Colors.black,
                              child: Text(
                                "SOME PERSONAL INFO FOR PUBLIC PROFILE",
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 0,
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              height: size.height * 0.2,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          color: Colors.black45, width: 1))),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintStyle: GoogleFonts.cabin(
                                        fontSize: size.width * 0.03,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                    border: InputBorder.none,
                                    hintText:
                                        "HERE YOU CAN WRITE SOME STUFF FOR YOUR PUBLIC PROFILE..."),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          width: size.width,
                          height: size.height * 0.06,
                          color: Colors.black,
                          child: Text(
                            "SAVE CHANGES",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top: size.height * 0.01),
                          alignment: Alignment.center,
                          width: size.width,
                          child: Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                                          },
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red[600],
                                    size: size.width * 0.1,
                                  )),
                              Text(
                                "DELETE PROFILE",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.width * 0.025),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          )),
    );
  }

  uploadImageToFireStore(BuildContext context) async {
    _reference.doc("${FirebaseAuth.instance.currentUser.uid}").update(
        {"personalInfo": _controllerPersonalInfo.text ?? ""}).whenComplete(() {
      final snackBar = SnackBar(
        content: Text(
          "Saved",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 1, milliseconds: 200),
        backgroundColor: Colors.black,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
    ref1 = firebase_storage.FirebaseStorage.instance
        .ref()
        .child("${FirebaseAuth.instance.currentUser.uid}");
    if (imageFile1 != null) {
      ref1.putFile(imageFile1).whenComplete(() {
        print("uploaded");
      }).catchError((onError) {});
    }
  }
  Future<void> _showMyDialog(BuildContext context,Size size) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(top: size.height*0.3,
          bottom: size.height*0.4),
          width: size.width,
          height: size.height*0.5,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Column(
               children: [
                 Container(
                   color: Colors.black,
                   alignment: Alignment.center,
                   width:size.width,
                   child: Text("ARE YOUR SHURE",style: GoogleFonts.roboto(
                       color: Colors.white,
                       fontSize: size.width*0.035,
                       decoration: TextDecoration.none
                   ),),
                   padding: EdgeInsets.symmetric(vertical: size.height*0.01),
                 ),
                 Container(
                   padding: EdgeInsets.symmetric(
                       horizontal: size.width*0.02,
                       vertical: size.height*0.01
                   ),
                   child: Text("DELETING YOUR PROFILE WILL ALSO DELETE ALL OF YOUR EVENTS,"
                       " ARE YOU SURE YOU WANT THIS?",
                     style: GoogleFonts.roboto(
                         color: Colors.black,
                         fontSize: size.width*0.035,
                         decoration: TextDecoration.none
                     ),),
                 ),
               ],
             ),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width*0.5,
                      height: size.height*0.035,
                      color: Colors.green[600],
                      child: Text("YES DELETE ALL",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: size.width*0.03,
                        decoration: TextDecoration.none
                      ),),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width*0.5,
                      height: size.height*0.035,
                      color: Colors.red[600],
                      child: Text("NO DON'T DELETE",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: size.width*0.03,
                            decoration: TextDecoration.none
                        ),),
                    ),
                  )
                ],
              )

            ],
          ),
        );
      },
    );
  }

}
