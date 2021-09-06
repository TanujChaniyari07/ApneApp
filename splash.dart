
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './index.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
FirebaseFirestore firestore = FirebaseFirestore.instance;
 CollectionReference users = FirebaseFirestore.instance.collection("Users");
 User user = FirebaseAuth.instance.currentUser;
  @override
  initState() {
   
         
           
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          
        ),
      ),
    );
  }
}