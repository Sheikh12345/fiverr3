import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:deto/Services/firestore_database.dart';
import 'package:deto/screens/login.dart';
import 'package:deto/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:deto/widgets/progress_dialog.dart';
import 'package:deto/sizes_helpers.dart';
import 'package:deto/components/constants.dart';
import 'package:deto/components/rounded_button.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signup_screen';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      textAlign: TextAlign.center,
    ));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(status: "Signing Up"));

    final User user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackBar(thisEx.message);
    }))
        .user;
    if (user != null) {
      print('success');
      Map<String, dynamic> userMap = {
        'name': nameController.text,
        'email': emailController.text,
        'personalInfo':""
      };

      Database().storeSignUpData(map: userMap);

      Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff969696),
        key: scaffoldKey,
        body: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(flip: true),
                child: Container(
                  height: displayHeight(context) * 0.27,
                  color: Color(0xff0d0d0d),
                ),
              ),
              Column(
                children: [
                  Logo(),
                  Container(
                    height: 20.0,
                    margin: EdgeInsets.only(
                      right: 5.0,
                      left: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff0d0d0d),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text('REGISTRIEREN :',
                              style: TextStyle(
                                  fontFamily: "Storopia",
                                  fontSize: 12.0,
                                  color: Color(0xFFFFFFFF)),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff0d0d0d),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0)),
                    ),
                    child: Container(
                      margin:
                          EdgeInsets.only(bottom: 2.0, right: 2.0, left: 2.0),
                      decoration: BoxDecoration(
                        color: Color(0xffcecece),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  labelText: 'Benutzername',
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Storopia',
                                      color: Colors.black),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10)),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Storopia',
                              ),
                            ),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'E-Mail',
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Storopia',
                                      color: Colors.black),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10)),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Storopia',
                              ),
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  labelText: 'Passwort',
                                  labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Storopia',
                                      color: Colors.black),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10)),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Storopia',
                              ),
                            ),
                            RoundedButton(
                              buttonColor: splashTextColor,
                              textColor: Colors.white,
                              title: 'Registrieren',
                              buttonWidth: displayWidth(context) * 1.00,
                              onPressed: () async {


                                var connectivityResult =
                                await Connectivity().checkConnectivity();
                                if (connectivityResult != ConnectivityResult.mobile &&
                                    connectivityResult != ConnectivityResult.wifi) {
                                  showSnackBar('Kein Internet');
                                  return;
                                }

                                if (nameController.text.length < 3) {
                                  showSnackBar('Geben Sie einen gültigen Namen ein');
                                  return;
                                }

                                if (passwordController.text.length < 8) {
                                  showSnackBar('Geben Sie ein gültiges Passwort ein');
                                  return;
                                }
                                if (!emailController.text.contains('@')) {
                                  showSnackBar('Geben Sie eine gültige E-Mail-Adresse ein');
                                  return;
                                }
                                registerUser();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Login.id, (route) => false);
                    },
                    child: Text(
                      "Hast du schon ein Konto? Hier anmelden",
                      style: TextStyle(fontFamily: 'Storopia', fontSize: 11),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
