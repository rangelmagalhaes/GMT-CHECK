//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmtchecklist/screens/login_screen.dart';
import 'package:gmtchecklist/screens/listView_screen.dart';
import 'package:gmtchecklist/screens/report_screen.dart';
import 'package:gmtchecklist/screens/splash_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF8b05f2),
          secondaryHeaderColor: Color(0xFF8b05f2),
        ),
    home: Splash(),
    debugShowCheckedModeBanner: false,
    color: Colors.white,
  )));

}


