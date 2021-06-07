import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xff0d0d0d),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
                'TYPE OF EVENT',
                style: TextStyle(
                    fontFamily: "Storopia",
                    fontSize: 12.0,
                    color: Color(0xFFFFFFFF)
                ),
                textAlign: TextAlign.center
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xffcecece),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 3.0,
                bottom: 3.0,
                right: 5.0,
                left: 5.0
            ),
            child: BlurryContainer(
              width: MediaQuery.of(context).size.width,
              bgColor: Colors.blueGrey,
              blur: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                      'CITY',
                      style: TextStyle(
                          fontFamily: "Storopia",
                          fontSize: 18.0,
                          color: Colors.black
                      ),
                  ),
                  Text(
                      'DATE',
                      style: TextStyle(
                          fontFamily: "Storopia",
                          fontSize: 18.0,
                          color: Colors.black
                      ),
                  ),
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.orange,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff0d0d0d),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'CUSTOM TEXT (DESCRIPTION)',
                style: TextStyle(
                    fontFamily: "Storopia",
                    fontSize: 10.0,
                    color: Color(0xFFFFFFFF)
                ),
                textAlign: TextAlign.center
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: expanded ? 120 : 0,
          child: Container(height: 120, color: Color(0xFFFFFFFF)),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Color(0xff0d0d0d),
          child: Container(
            margin: EdgeInsets.only(
                bottom: 1.0,
                right: 1.0,
                left: 1.0
            ),
            decoration: BoxDecoration(
              color: Color(0xffcecece),
            ),
            child: BlurryContainer(
              padding: const EdgeInsets.all(5.0),
              bgColor: Colors.white,
              blur: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ClipOval(
                    child: Material(
                      color: Color(0xff0d0d0d),
                      child: InkWell(
                          splashColor: Colors.blue,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          onTap: () => ('')
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Color(0xff0d0d0d),
                      child: InkWell(
                          splashColor: Colors.blue,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          onTap: () => ('')
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Color(0xff0d0d0d),
                      child: InkWell(
                          splashColor: Colors.blue,
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: Icon(
                              Icons.chat,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          onTap: () => ('')
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: FloatingActionButton(
                      child:
                      Icon(
                          expanded ? Icons.arrow_upward : Icons.arrow_downward, size: 15),
                      onPressed: () => setState(() {
                        expanded = !expanded;
                      }),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}