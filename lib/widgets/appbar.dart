import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool drawerCanOpen = true;

  resetApp() {
    setState(() {
      drawerCanOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}