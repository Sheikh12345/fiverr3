import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database{
  storeSignUpData({Map map})async{
    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).set(
        map
    ).whenComplete((){
      print("Saved sign up data");
    });
  }
}