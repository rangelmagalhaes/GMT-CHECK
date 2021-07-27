import 'package:flutter/cupertino.dart';
import 'package:gmtchecklist/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'datas/task_data.dart';

class TaskTab extends StatelessWidget {

  final String turno;
  final TaskData task;

  TaskTab( this.turno, this.task);

  showImageDialog(BuildContext context){

    return  showDialog(context: context,
        builder: (context){
          return AlertDialog(

              actions: <Widget>[
                Column(children: <Widget>[
                    Image.network(task.url_img,
                        loadingBuilder: (context,child,progress)=>progress == null
                            ?child:
                            Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF8b05f2),),),
                        fit: BoxFit.cover),
                    ],
                  )
                ],
                );
        });

  }
  @override
  Widget build(BuildContext context) {

    if(task.url_img != "" && task.comentario != ""){
      return ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return Padding(
              padding: EdgeInsets.only(right: 20.0,left: 20.0, top: 10.0, bottom: 10.0),
              child: Container(
                height: (task.resposta == "")? 180:200,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF8b05f2),
                        Color(0xFFa95ae6)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20),),

                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ListView(children:
                    <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                          child: Text(task.pergunta,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontStyle: FontStyle.italic
                            ),),
                        ),
                      ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:(task.resposta!="")? Text("R: "+
                                task.resposta,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic
                              ),
                            ):null,
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("PS: "+ task.comentario,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                          )
                      ),
                      SizedBox(height: 20,),
                      Align(child:   Container(
                        width: MediaQuery.of(context).size.width/5,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)
                            ),
                            color:  Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5
                              )
                            ]),
                        child: Center(
                          child:  IconButton(onPressed:()async{
                            showImageDialog(context);
                          },
                            color: Colors.purple,
                            icon: Icon(Icons.attach_file_sharp),iconSize: 20.0,),
                        ),
                      ),
                        alignment: Alignment.bottomCenter,)

                    ],
                    )
                ),
              ),
            );

          });
    }else if(task.url_img != ""){
      return ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return Padding(
              padding: EdgeInsets.only(right: 20.0,left: 20.0, top: 10.0, bottom: 10.0),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8b05f2),
                        Color(0xFFa95ae6)
                      ],
                    ),

                    borderRadius: BorderRadius.all(Radius.circular(20),),

                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                          child: Text(task.pergunta,
                            style: TextStyle(
                              fontSize: 16.0,
                                color: Colors.white,
                               // fontStyle: FontStyle.italic,
                            ),),
                        ),
                      ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("R: "+
                                task.resposta,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                          )
                      ),
                      SizedBox(height: 20,),
                      Align(child:   Container(
                        width: MediaQuery.of(context).size.width/5,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)
                            ),
                            color:  Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5
                              )
                            ]),
                        child: Center(
                          child:  IconButton(onPressed:()async{
                            showImageDialog(context);
                          },
                            color: Colors.purple,
                            icon: Icon(Icons.attach_file_sharp),iconSize: 20.0,),
                        ),
                      ),
                      alignment: Alignment.bottomCenter,)

                    ],),
                ),
              ),
            );

          });
    }else if(task.comentario != ""){
      return ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return Padding(
              padding: EdgeInsets.only(right: 20.0,left: 20.0, top: 10.0, bottom: 10.0),
              child: Container(
                height: (task.resposta == "")? 150:170,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF8b05f2),
                        Color(0xFFa95ae6)],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20),),

                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ListView(children:
                      <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                            child: Text(task.pergunta,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic
                              ),),
                          ),
                        ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top:10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: (task.resposta!="")? Text("R: "+
                                  task.resposta,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic
                                ),
                              ):null,
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.only(top:10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("PS: "+ task.comentario,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic
                                ),
                              ),
                            )
                        ),

                      ],
                  )
                ),
              ),
            );

          });
    }else{
      return ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return Padding(
              padding: EdgeInsets.only(right: 20.0,left: 20.0, top: 10.0, bottom: 10.0),
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8b05f2),
                        Color(0xFFa95ae6)
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20),),

                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                          child: Text(task.pergunta,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                //fontStyle: FontStyle.italic
                            ),),
                        ),
                      ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("R: "+
                                task.resposta,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                          )
                      ),

                    ],),
                ),
              ),
            );

          });
    }



  }
}
