import 'package:flutter/material.dart';

double screenHeight;

Size displaySize(BuildContext context) {

  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  screenHeight = displaySize(context).height;

  return displaySize(context).height;
}

double displayWidth(BuildContext context) {

  return displaySize(context).width;
}
