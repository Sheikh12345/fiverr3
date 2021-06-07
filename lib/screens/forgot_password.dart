import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:deto/sizes_helpers.dart';
import 'package:deto/components/rounded_button.dart';
import 'package:deto/screens/login.dart';
import 'package:deto/screens/signup.dart';
import 'package:deto/widgets/logo.dart';

class ForgotPassword extends StatefulWidget {
  static const String id = 'forgotPassword_screen';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff969696),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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
                            'PASSWORT ÄNDERN :',
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
                                labelText: 'E-mail eingeben',
                                labelStyle: TextStyle(fontSize: 14,fontFamily: 'Storopia', color: Colors.black),
                                hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10)),
                            style: TextStyle(fontSize: 14,fontFamily: 'Storopia',),
                          ),
                          RoundedButton(
                            buttonColor: Colors.black,
                            textColor: Colors.white,
                            title: 'Bestätigen',
                            buttonWidth: displayWidth(context) * 1.00,
                            onPressed: () {
                              _auth.sendPasswordResetEmail(email:emailController.text);
                              Navigator.pushNamed(context, Login.id);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignUp.id, (route) => false);
                  },
                  child: Text("Noch kein Konto ? dann melden Sie sich hier an",style: TextStyle(fontFamily: 'Storopia', fontSize: 11),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
