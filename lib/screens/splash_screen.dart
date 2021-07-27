import 'package:flutter/material.dart';
import 'package:gmtchecklist/screens/login_screen.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> LoginScreen(title: ''))
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8b05f2),
              Color(0xFFa95ae6)
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Expanded(child:
                Align(
                child:
                Container(
                  width: 143,
                  height: 143,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      shape: BoxShape.circle
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 140,
                          height: 140,
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
                                  width: 100,height: 100,),
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
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top:0,
                    right: 0, bottom: 80.0),
                child: Text('GMT-CHECK', style: TextStyle(
                    color:Colors.white,
                    fontSize: 25.0
                ),),
              ),
            ),
          ],
        ),),
    );
  }
}

