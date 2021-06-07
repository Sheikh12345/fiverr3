import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:deto/screens/forgot_password.dart';
import 'package:deto/screens/home.dart';
import 'package:deto/widgets/logo.dart';
import 'package:deto/screens/signup.dart';
import 'package:deto/components/constants.dart';
import 'package:deto/components/rounded_button.dart';
import 'package:deto/sizes_helpers.dart';
import 'package:deto/widgets/progress_dialog.dart';

class Login extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String message) {
    final snackBar = SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void login() async {

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context)=>ProgressDialog(status: "Sie werden eingeloggt")
    );
    try {

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (userCredential != null) {
        Navigator.pop(context);
        Navigator.pushNamed(context, Home.id);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        print('Für diese E-Mail wurde kein Benutzer gefunden');
        showSnackBar(e.message);
      } else if (e.code == 'wrong-password') {
        print('Für diesen Benutzer wurde ein falsches Passwort angegeben');
        showSnackBar(e.message);
      }
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
                  height: displayHeight(context)*0.27,
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
                          topRight: Radius.circular(10.0)
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                              'LOGIN :',
                              style: TextStyle(
                                  fontFamily: "Storopia",
                                  fontSize: 12.0,
                                  color: Color(0xFFFFFFFF)
                              ),
                              textAlign: TextAlign.center
                          ),
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
                          bottomLeft: Radius.circular(5.0)
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 2.0,
                          right: 2.0,
                          left: 2.0
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffcecece),
                        borderRadius: BorderRadius.all(Radius.circular(5)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'E-Mail',
                                  labelStyle: TextStyle(fontSize: 14,fontFamily: 'Storopia', color: Colors.black),
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 10)),
                              style: TextStyle(fontSize: 13,fontFamily: 'Storopia'),
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  labelText: 'Passwort',
                                  labelStyle: TextStyle(fontSize: 14,fontFamily: 'Storopia', color: Colors.black),
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 10)),
                              style: TextStyle(fontSize: 13,fontFamily: 'Storopia',),
                            ),
                            RoundedButton(
                              buttonColor: splashTextColor,
                              textColor: Colors.white,
                              title: 'Einloggen',
                              buttonWidth: displayWidth(context) * 1.0,
                              onPressed: () {
                                login();
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
                          context, ForgotPassword.id, (route) => false);
                    },
                    child: Text("Passwort vergessen ?",style: TextStyle(fontFamily: 'Storopia',fontSize: 11),),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, SignUp.id, (route) => false);
                    },
                    child: Text("Sie haben kein Konto, melden Sie sich hier an",style: TextStyle(fontFamily: 'Storopia',fontSize: 11),),
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

