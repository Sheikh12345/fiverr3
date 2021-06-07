import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deto/Common/functions.dart';
import 'package:deto/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

import 'package:deto/screens/home.dart';
import 'package:deto/screens/login.dart';
import 'package:deto/screens/about.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  CollectionReference _fireRefUsers =
      FirebaseFirestore.instance.collection("Users");

  String _profileUrl;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event.uid != null) {
        firebase_storage.FirebaseStorage.instance
            .ref()
            .child("${FirebaseAuth.instance.currentUser.uid}")
            .getDownloadURL()
            .then((value) {
          setState(() {
            _profileUrl = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(top: size.height * 0.07, bottom: size.height * 0.07),
      child: Container(
        width: 210,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
        ),
        child: ListView(
          children: [
            FirebaseAuth.instance.currentUser != null
                ? GestureDetector(
                    onTap: () {
                      screenPushRep(context, ProfileScreen());
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.025,
                              bottom: size.height * 0.01),
                          width: size.width * 0.28,
                          height: size.width * 0.28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: _profileUrl != null
                                    ? NetworkImage(_profileUrl)
                                    : AssetImage("images/logo.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StreamBuilder(
                            stream: _fireRefUsers
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: 300,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    color: Color(0xff0d0d0d),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data["name"]}',
                                      style: TextStyle(
                                          fontFamily: 'Storopia',
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      final snackBar = SnackBar(
                        content: Text(
                            "Bitte loggen Sie sich ein und versuchen Sie es dann"),
                        duration: Duration(milliseconds: 1200),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: size.height * 0.025,
                              bottom: size.height * 0.01),
                          width: size.width * 0.28,
                          height: size.width * 0.28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage("images/logo.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          height: 17,
                          decoration: BoxDecoration(
                            color: Color(0xff0d0d0d),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Center(
                            child: Text(
                              'Nutzername',
                              style: TextStyle(
                                  fontFamily: 'Storopia',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.home_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  'Startseite',
                  style: TextStyle(fontFamily: 'Storopia', fontSize: 11),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Home.id);
              },
            ),
            Container(
              width: 300,
              height: 0.3,
              color: Colors.black12,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.add_alarm_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  'Demo eintragen',
                  style: TextStyle(fontFamily: 'Storopia', fontSize: 11),
                ),
              ),
              onTap: () {
                //Navigator.pushNamed(context, AddEvent.id);
              },
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.settings_applications_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(fontFamily: 'Storopia', fontSize: 11),
                ),
              ),
              onTap: () {
                //Navigator.pushNamed(context, Notifications.id);
              },
            ),
            Container(
              width: 300,
              height: 0.3,
              color: Colors.black12,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.login_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  'Einloggen',
                  style: TextStyle(fontFamily: 'Storopia', fontSize: 11),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, Login.id);
              },
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  'Ausloggen',
                  style: TextStyle(fontFamily: 'Storopia', fontSize: 11),
                ),
              ),
              onTap: () {},
            ),
            Container(
              width: 300,
              height: 0.3,
              color: Colors.black12,
            ),
            InkWell(
              child: ListTile(
                leading: Icon(
                  Icons.info_rounded,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  'DETO ?',
                  style: TextStyle(fontFamily: 'Storopia', fontSize: 11),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, About.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
