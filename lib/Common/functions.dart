import 'package:flutter/material.dart';

screenPush(BuildContext context,Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>widget));
}

screenPushRep(BuildContext context,Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>widget));
}