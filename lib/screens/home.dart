import 'package:deto/sizes_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:deto/widgets/drawer.dart';
import 'package:deto/widgets/home_widget.dart';
import 'package:deto/widgets/appbar.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
//        appBar: CustomAppBar(),
        endDrawer: AppDrawer(),
        key: scaffoldKey,
        backgroundColor: Color(0xff969696),
        body: Stack(
          children: [
            ClipPath(
              clipper: WaveClipperTwo(flip: true),
              child: Container(
                height: displayHeight(context) * 0.18,
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
                SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: HomeWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
