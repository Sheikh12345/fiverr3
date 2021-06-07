import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:deto/sizes_helpers.dart';

class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: displayHeight(context) * 0.45,
            width: displayWidth(context) * 0.45,
            child: Image.asset(
                'images/logo.png'
            ),
          ),
        ]
    );
  }
}
