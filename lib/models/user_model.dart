
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmtchecklist/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class UserModel extends Model {

  FirebaseAuth _auth = FirebaseAuth.instance;
  var firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;



  void signUp({required Map<String, dynamic> userData, required String pass,
    required VoidCallback onSucess, required VoidCallback onFail}){
    isLoading = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
        email: userData["e-mail"],
        password: pass
    ).then((authResult)async{
      firebaseUser = authResult.user;

       await _saveUserData(userData);//saldar dados do usuario fora e-mail e senha

      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn({required Map<String, dynamic> userData, required String pass,
    required VoidCallback onSucess, required VoidCallback onSucessReport,required VoidCallback onSucessReportInc, required VoidCallback onFail}) async {

    this.userData = userData;
    isLoading = true;
    notifyListeners(); //como o model foi atualizado, modifica a view

    _auth.signInWithEmailAndPassword(email: userData["e-mail"], password: pass).then((value)async{

      firebaseUser = value.user;

      await Future.delayed(Duration(seconds: 3));
      if(firebaseUser.uid == "SIRzZgq9PoSTuPFQcd6kD1n43s72" || firebaseUser.uid == "41lhqmr2W3NWa1jgh4ziplGinUE2" ||
          firebaseUser.uid == "wiaDM0hGMHdSTtDKHMex92z7tCb2"){
        onSucessReport();
      }else if(firebaseUser.uid == "jUvpbls89sWMWWsDA4hJ2xgfA2m2"){
        onSucessReportInc();
      }else{
        onSucess();
      }
      await Future.delayed(Duration(seconds: 1));
      isLoading = false;
      notifyListeners();


    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });

  }

  void signOut(BuildContext context) async {


    Navigator.of(context).pop();
    await Future.delayed(Duration(seconds: 2));
    await _auth.signOut();
    Future.delayed(Duration(seconds: 2)).then((_){
      userData = Map();
    });
    firebaseUser = null;
    notifyListeners();

  }

  void recoverPass(){


  }

  Future<Null> _saveUserData( Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection("USUARIO").doc(firebaseUser.uid).set(userData);
  }

}

