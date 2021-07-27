import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmtchecklist/models/user_model.dart';
import 'package:gmtchecklist/screens/report_screen.dart';
import 'package:gmtchecklist/screens/report_screen_inc.dart';
import 'package:scoped_model/scoped_model.dart';

import 'listView_screen.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  BuildContext get context => _scaffoldKey.currentState!.context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height/2.5,
                decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8b05f2),
                        Color(0xFFa95ae6)
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(90)
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10
                      )
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 32,left: 32,top: 32,bottom: 32),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Expanded(child:
                          Align(
                            child:Container(
                              width: 123,
                              height: 123,
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  shape: BoxShape.circle
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFF8b05f2),
                                            Color(0xFFa95ae6)
                                          ],
                                        ),),
                                      child:Stack(
                                        children: [
                                          Center(
                                            child:  Image.asset("images/logobran.png",
                                              width: 90,height: 90,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        ],

                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top:0,
                              right: 0),
                          child: Text('GMT-CHECK', style: TextStyle(
                              color:Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0
                          ),),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 75),
                child: ScopedModelDescendant<UserModel>(
                  builder: (context, child, model){

                    if(model.isLoading){
                      return Container(
                        width: 150,
                        height: 150,
                        child:Center(
                          child: CircularProgressIndicator(color: Color(0xFF8b05f2),),
                        ),
                      );
                    }

                    return Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 50,
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16, bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5
                                )
                              ]
                          ),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.email,
                                color: Color(0xFFd5dbd9),),
                              hintText: 'E-mail',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: 50,
                          margin: EdgeInsets.only(top: 32),
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16, bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5
                                )
                              ]
                          ),
                          child: TextField(
                            controller: _passController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(Icons.vpn_key,
                                color: Color(0xFFd5dbd9),),
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top:16,
                                right: 32),
                            child: Text('Forgot Password ?', style: TextStyle(
                                color:Colors.grey
                            ),),
                          ),
                        ),

                        Container(

                          width: MediaQuery.of(context).size.width/1.2,
                          height: 50,
                          margin: EdgeInsets.only(top: 75),
                          padding: EdgeInsets.only(
                              top: 4,left: 16, right: 16, bottom: 4
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color(0xFF8b05f2),
                                  Color(0xFFa95ae6)
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5
                                )
                              ]
                          ),

                          child: GestureDetector(
                            onTap: (){
                              Map<String, dynamic> userData = {
                                "e-mail" : _emailController.text,
                                "senha" : _passController.text,
                              };
                              //model.signUp(userData: userData,pass: _passController.text, onSucess: _onSucess, onFail: _onFail);
                              model.signIn(userData: userData, pass: _passController.text, onFail: _onFail, onSucess: _onSucess, onSucessReport: _onSucessReport,onSucessReportInc:_onSucessReportInc );
                            },
                            child: Center(
                              child: Text('LOGIN'.toUpperCase(),
                                style:TextStyle(
                                  color: Colors.white,

                                ),
                              ),
                            ),
                          ),

                        ),

                      ],
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      )
    );
  }

  void _onSucess(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ListaTarefas()),);
      _passController.text = "";
  }
  void _onSucessReport(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ReportScreen()),);
    _passController.text = "";
  }
  void _onSucessReportInc(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ReportScreenInc()),);
    _passController.text = "";
  }
  void _onFail(){
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content:  Text("Falha ao entrar",
        textAlign: TextAlign.center,),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
    ));

  }
}


