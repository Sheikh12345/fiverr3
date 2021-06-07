import 'dart:async';
import 'package:deto/sizes_helpers.dart';
import 'package:deto/screens/home.dart';
import 'package:deto/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

class Launch extends StatefulWidget {
  static const String id = 'launch_screen';
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  final splashDelay = 20;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Home()));
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
              clipper: WaveClipperTwo(),
              child: Container(
                height: displayHeight(context) * 0.27,
                color: Color(0xff0d0d0d),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Logo(),
                  Container(
                height: 20.0,
                margin: EdgeInsets.only(
                  right: 20.0,
                  left: 20.0,
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
                          'Dein Event-Terminkalender und Organizer',
                          style: TextStyle(
                              fontFamily: "Storopia",
                              fontSize: 13.0,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            'Willkommen lieber DETO Nutzer,',
                            style: TextStyle(
                                fontFamily: "Storopia",
                                fontSize: 12.0,
                                color: Colors.black
                            ),
                            textAlign: TextAlign.center
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Hiermit wollen wir euch einen Demoevent-Terminkalender & Organizer für eure Events zur Verfügung stellen, er soll euch dabei helfen eure Events möglichst einfach und unkompliziert für alle Menschen zentral gesammelt zur Verfügung zu stellen, sodass niemand ein Event verpasst :)',
                            style: TextStyle(
                                fontFamily: "Storopia",
                                fontSize: 10.0,
                                color: Colors.black
                            ),
                            textAlign: TextAlign.center
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            'Gerne könnt ihr auch selbst eure Events dort eintragen und allen andern somit zur Verfügung stellen, wir wünschen euch viel Erfolg bei euren Veranstaltungen.',
                            style: TextStyle(
                                fontFamily: "Storopia",
                                fontSize: 10.0,
                                color: Colors.black
                            ),
                            textAlign: TextAlign.center
                        ),
                      ],
                    ),
                  ),
                ),
              ),
                  SizedBox(
                    height: displayHeight(context) * 0.03,
                  ),
                  ArgonTimerButton(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.90,
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    highlightColor: Colors.blue,
                    highlightElevation: 10,
                    roundLoadingShape: true,
                    splashColor: Colors.blue,
                    onTap: (startTimer, btnState) {
                      if (btnState == ButtonState.Idle) {
                        startTimer(30);
                      }
                    },
                    initialTimer: 20,
                    child: Text(
                      "WEITER",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Storopia',
                          fontSize: 12,
                      ),
                    ),
                    loader: (timeLeft) {
                      return Text(
                        "WARTE $timeLeft SEKUNDEN",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Storopia',
                            fontSize: 12,
                        ),
                      );
                    },
                    borderRadius: 5.0,
                    color: Colors.black,
                    elevation: 0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}