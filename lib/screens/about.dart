import 'package:deto/sizes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:deto/widgets/drawer.dart';
import 'package:deto/widgets/logo.dart';

class About extends StatefulWidget {
  static const String id = 'about';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool drawerCanOpen = true;

  resetApp() {
    setState(() {
      drawerCanOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xff969696),
        endDrawer: AppDrawer(),
        body: Stack(
          children: [
            ClipPath(
              clipper: WaveClipperTwo(flip: true),
              child: Container(
                height: displayHeight(context)* 0.27,
                color: Color(0xff0d0d0d),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 20),
                  child: Row(
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                            fontFamily: 'Storopia',
                            fontSize: 15.0,
                            color: Colors.white
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('DETO'),
                          ],
                          isRepeatingAnimation: false,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            if (drawerCanOpen) {
                              scaffoldKey.currentState.openEndDrawer();
                            } else {
                              resetApp();
                            }
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
                      padding: const EdgeInsets.only(left: 5.0),
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
                            'Demokratischer Event-Teriminkalender und Organizer',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                              style: TextStyle(
                                  fontFamily: "Storopia",
                                  fontSize: 11.0,
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
        ),
      ),
    );
  }
}
