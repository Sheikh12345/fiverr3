import 'package:deto/sizes_helpers.dart';
import 'package:deto/screens/launch_screen.dart';
import 'package:deto/screens/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deto/widgets/logo.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(seconds: 4);

    if (firstTime != null && !firstTime) {
      // Not first time
      return new Timer(_duration, navigationPageHome);
    } else {
      // First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationPageWel);
    }
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed(Home.id);
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed(Launch.id);
  }

  final splashDelay = 5;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, startTime);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff969696),
          body: Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(flip: true),
                child: Container(
                  height: displayHeight(context) * 0.47,
                  color: Color(0xff0d0d0d),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      ],
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.03,
                  ),
                  Logo(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.05,
                  ),
                  Container(
                    height: 20.0,
                    margin: EdgeInsets.only(
                      right: 30.0,
                      left: 30.0,
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
                              'DEIN ORGANIZER FÜR DEMOTERMINE UND DEMOKRATISCHE-EVENTS',
                              style: TextStyle(
                                  fontFamily: "Storopia",
                                  fontSize: 9.0,
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
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
                        color: Color(0xffc9c9c9),
                        borderRadius: BorderRadius.all(Radius.circular(5)
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                'DEMOS ANMELDEN & VERWALTEN',
                                style: TextStyle(
                                    fontFamily: "Storopia",
                                    fontSize: 8.0,
                                    color: Colors.black
                                ),
                                textAlign: TextAlign.center
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                                'FINDE VERANSTALTUNGEN IN DEINER NÄHE',
                                style: TextStyle(
                                    fontFamily: "Storopia",
                                    fontSize: 8.0,
                                    color: Colors.black
                                ),
                                textAlign: TextAlign.center
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                                'BESTÄTIGE DEINE TEILNAME',
                                style: TextStyle(
                                    fontFamily: "Storopia",
                                    fontSize: 8.0,
                                    color: Colors.black
                                ),
                                textAlign: TextAlign.center
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
