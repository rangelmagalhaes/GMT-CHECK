import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:gmtchecklist/models/user_model.dart';
import 'package:gmtchecklist/helpers/tarefa_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import '../helpers/turno_helper.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';


class ListaTarefas extends StatefulWidget {
  ListaTarefas({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ListaTarefas> {

  static final String tarefas_turno_1 = "Tarefas Manhã";
  static final String tarefas_turno_2 = "Tarefas Intermediário";
  static final String tarefas_turno_3 = "Tarefas Fechamento";
  final _comentController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TarefasHelper helper = new TarefasHelper();
  List _TarefasManha = [];
  List _TarefasIntermediario = [];
  List _TarefasFechamento = [];

  Turno _turnoManha = new Turno(false,[]);
  Turno _turnoIntermediario = new Turno(false,[]);
  Turno _turnoFechamento = new Turno(false,[]);

  File _image = new File("");
  File _image_1 = new File("");
  File _image_2 = new File("");

  String day = "";
  String month = "";
  String year = "";

  String _turno = tarefas_turno_1;
  set turno(String turno){
    if(turno == tarefas_turno_1){
      _turno = tarefas_turno_1;
    }else if(turno == tarefas_turno_2){
      _turno = tarefas_turno_2;
    }else{
      _turno = tarefas_turno_3;
    }

  }

  List _tarefas = [];
  List get tarefas => _tarefas;
  set tarefas(List tarefas){
    _tarefas = tarefas;
  }


  @override
  void initState() {
    // TODO: implement initState
    //implementar em caso de atualização da lista
    super.initState();
    _TarefasManha = helper.criarTarefasManha();
    _TarefasIntermediario = helper.criarTarefasIntermediario();
    _TarefasFechamento = helper.criarTarefasFechamento();

   _turnoManha.tarefas = _TarefasManha;
   _turnoIntermediario.tarefas = _TarefasIntermediario;
   _turnoFechamento.tarefas = _TarefasFechamento;

    var now = DateTime.now();
    day = now.day.toString();
    month = now.month.toString();
    year = now.year.toString();
  }

  Future <void> showFinishDialog(BuildContext context, UserModel model) async{
    return await showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("FINALIZAR"),
            content: Text("Deseja enviar Formulário?"),
            actions: <Widget>[
              Row(children: <Widget>[
                FlatButton(onPressed: ()async{
                  showWaiting(context);
                  if(_turno == tarefas_turno_1){
                    saveData(model.firebaseUser.uid, _turno).then((T){
                      Navigator.of(context).pop();
                      setState(() {
                        _turnoManha.finalizado = true;
                      });
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content:  Text("Dados enviados com sucesso",
                        textAlign: TextAlign.center,),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.greenAccent,
                      ));
                    }).catchError((e){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content:  Text("Erro ao enviar os dados",
                          textAlign: TextAlign.center,),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                      ));
                    });
                  }else if(_turno == tarefas_turno_2){
                    saveData(model.firebaseUser.uid, _turno).then((T){
                      Navigator.of(context).pop();
                      setState(() {
                        _turnoIntermediario.finalizado = true;
                      });
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content:  Text("Dados enviados com sucesso",
                          textAlign: TextAlign.center,),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.greenAccent,
                      ));
                    }).catchError((e){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content:  Text("Erro ao enviar os dados",
                          textAlign: TextAlign.center,),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                      ));
                    });
                  }else{
                    saveData(model.firebaseUser.uid, _turno).then((T){
                      Navigator.of(context).pop();
                      setState(() {
                        _turnoFechamento.finalizado = true;
                      });
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content:  Text("Dados enviados com sucesso",
                          textAlign: TextAlign.center,),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.greenAccent,
                      ));
                    }).catchError((e){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content:  Text("Erro ao enviar os dados",
                          textAlign: TextAlign.center,),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                      ));
                    });

                  }

                }, child: Text("SIM"),
                  minWidth: MediaQuery.of(context).size.width/5,
                ),
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("CANCELAR"),
                  minWidth: MediaQuery.of(context).size.width/5,
                )
              ],
              ),
            ],
          );
        });

  }
  showWaiting(BuildContext context,){
    return  showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("AGUARDE..."),
            actions: <Widget>[
              SizedBox(height: 100,
              child:Center(child: LinearProgressIndicator(
                color: Color(0xFF8b05f2),
              )),


              ),
            ],
          );
        });
  }
  showComentsDialog(BuildContext context, Tarefa tarefa){
    _comentController.text = tarefa.comentario;
    return  showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("COMENTE"),
            actions: <Widget>[
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Expanded(child: TextField(
                      controller: _comentController,
                      decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: tarefa.comentario == "" ? 'Escreva aqui': tarefa.comentario,
                    ),

                    )
                    )
                  ],
                ),
                Row(
                  children: [
                    FlatButton(onPressed: (){
                      tarefa.comentario = _comentController.text;
                      Navigator.of(context).pop();
                    }, child: Text("OK"),
                      minWidth: MediaQuery.of(context).size.width/5,
                    ),
                    FlatButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("CANCELAR"),
                      minWidth: MediaQuery.of(context).size.width/5,
                    )
                  ],
                ),
              ],
              ),
            ],
          );
        });

  }
  showImageDialog(BuildContext context, Tarefa tarefa){

    return  showDialog(context: context,
        builder: (context){
          return AlertDialog(

            actions: <Widget>[
              Column(children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  child: Image.file(File(tarefa.fileimg!.path),fit: BoxFit.cover),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    FlatButton(onPressed: (){
                    Navigator.of(context).pop();
                    }, child: Text("OK"),
                      textColor: Colors.white,
                    minWidth: MediaQuery.of(context).size.width/2.8,

                      color: Colors.deepPurple,
                    ),
                    Padding(padding: EdgeInsetsDirectional.only(start: 5.0)),
                    FlatButton(onPressed: (){
                      tarefa.fileimg = null;
                      Navigator.of(context).pop();
                    }, child: Text("DELETAR"),
                      textColor: Colors.white,
                     minWidth: MediaQuery.of(context).size.width/2.8,
                      color: Colors.deepPurple,
                     )
                    ],
              )

            ],
          )]);
        });

  }

  @override
  Widget build(BuildContext context) {

    if(_turno == tarefas_turno_1){
      tarefas = _TarefasManha;
    }else if(_turno == tarefas_turno_2){
      tarefas = _TarefasIntermediario;
    }else{
      tarefas = _TarefasFechamento;
    }

    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
            return WillPopScope(
                onWillPop:  () async => false,
                child: Scaffold(
                  key:_scaffoldKey,
                  appBar: AppBar(
                    title: Text(_turno),
                    toolbarHeight: 70,
                    backgroundColor: Color(0xFF8b05f2),
                    elevation: 0.0,
                  ),
                  drawer: Drawer(child:_customDrawer(context)),
                  body: Container(
                    child:FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance.collection("USUARIO").doc(model.firebaseUser.uid).
                            collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
                            collection((_turno == tarefas_turno_1)?"TAREFAS_MANHÃ":((_turno == tarefas_turno_2)?
                            "TAREFAS_INTERMEDIÁRIO":"TAREFAS_FECHAMENTO")).get(),
                            builder: (context,snapshot){
                              Future.delayed(Duration(seconds: 2));
                              if(!snapshot.hasData){

                                return Center(child: CircularProgressIndicator(color: Color(0xFF8b05f2),),);
                              }else{
                                if(snapshot.requireData.docs.isNotEmpty){

                                    if (_turno == tarefas_turno_1) _turnoManha.finalizado = true;
                                    if (_turno == tarefas_turno_2) _turnoIntermediario.finalizado = true;
                                    if (_turno == tarefas_turno_3) _turnoFechamento.finalizado = true;

                                  return Container(
                                      child: Center(
                                        child: Text("Tarefas Enviadas",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                          color: Colors.grey),),
                                      )
                                  );
                                }else{

                                  if (_turno == tarefas_turno_1) _turnoManha.finalizado = false;
                                  if (_turno == tarefas_turno_2) _turnoIntermediario.finalizado = false;
                                  if (_turno == tarefas_turno_3) _turnoFechamento.finalizado = false;
                                  return  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.only(
                                              right: 20.0, left: 20.0, top: 10.0),
                                              child: Text(intToString(isFinished()) +"/"+(tarefas.length).toString()+
                                                  " Tarefas Finalizadas",
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      color: Colors.black87
                                                  )
                                              )
                                          )
                                        ],
                                      ),
                                      Padding(padding: EdgeInsets.only(
                                          right: 20.0, left: 20.0, top: 10.0, bottom: 0.0),
                                        child: LinearProgressIndicator(
                                          minHeight: 2.0,
                                          value: isFinished() * (1 / tarefas.length),
                                          color: Color(0xFF8b05f2),
                                          backgroundColor: Color(0xffc89cef),
                                        ),
                                      ),
                                      Expanded(
                                        child:ListView.builder(
                                                itemBuilder: (context,index){
                                                  return _tarefaContainer(context,index);
                                                } ,
                                                itemCount: tarefas.length,
                                                scrollDirection: Axis.vertical,
                                                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
                                              ),
                                      ),
                                    ],
                                  );
                                }
                              }

                            },
                          ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      model.signOut(context);
                    },
                    child: Expanded(
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Icon(Icons.arrow_back_outlined),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF8b05f2),
                              Color(0xFFa95ae6)
                            ],
                          ),

                        ),
                      ),
                    ),

                  ),
                )
            );

              },
            );
  }
  Widget _customDrawer(BuildContext context){

    return ScopedModelDescendant<UserModel>(
              builder:(context,child,model){
                return FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection("USUARIO").doc(
                        model.firebaseUser.uid).collection("LOJA").get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator(color: Color(0xFF8b05f2)));
                      } else {
                        return Drawer(
                                   child: Stack(
                                     children: <Widget>[
                                       Container(
                                         decoration: BoxDecoration(
                                           gradient: LinearGradient(
                                             begin: Alignment.topCenter,
                                             end: Alignment.bottomCenter,
                                             colors: [
                                               Color(0xFF8b05f2),
                                               Color(0xFFa95ae6),
                                               // Color(0xFF831E91),
                                               //Color(0xFFFD8231),

                                             ],
                                           ),
                                         ),
                                       ),
                                       ListView(
                                         padding: EdgeInsets.only(
                                             left: 32.0, top: 16.0, right: 16.0),
                                         children: <Widget>[
                                           Container(
                                             margin: EdgeInsets.only(bottom: 4.0),
                                             padding: EdgeInsets.fromLTRB(
                                                 0.0, 16.0, 16.0, 0.0),
                                             height: 170.0,
                                             child: Stack(
                                               children: <Widget>[
                                                 Positioned(
                                                   top: 20.0,
                                                   left: 0.0,
                                                   child: Text("GMT-CHECK",
                                                     style: TextStyle(
                                                         fontSize: 34.0,
                                                         fontWeight: FontWeight.bold,
                                                         fontStyle: FontStyle.italic,
                                                         color: Colors.white
                                                     ),
                                                   ),
                                                 ),
                                                 Positioned(
                                                   bottom: 0.0,
                                                   left: 0.0,
                                                   child: Column(
                                                     crossAxisAlignment: CrossAxisAlignment
                                                         .start,
                                                     children: [
                                                       Text("Olá, " + snapshot.requireData.docs.first["gerente"],
                                                         style: TextStyle(
                                                             fontSize: 18.0,
                                                             //fontWeight: FontWeight.bold,
                                                             fontStyle: FontStyle
                                                                 .italic,
                                                             color: Colors.white
                                                         ),
                                                       ),
                                                       SizedBox(height: 4.0,),
                                                       Text(
                                                         snapshot.requireData.docs.first["nome"],
                                                         style: TextStyle(
                                                             fontSize: 14.0,
                                                             //fontWeight: FontWeight.bold,
                                                             fontStyle: FontStyle
                                                                 .italic,
                                                             color: Colors.deepPurple
                                                         ),
                                                       )

                                                     ],
                                                   ),
                                                 ),

                                               ],
                                             ),
                                           ),
                                           Divider(),
                                           _DrawerTitle(context, (_turnoManha.finalizado) ? Icons.check : Icons.cancel_outlined, tarefas_turno_1),
                                           _DrawerTitle(context, (_turnoIntermediario.finalizado) ? Icons.check : Icons.cancel_outlined, tarefas_turno_2),
                                           _DrawerTitle(context, (_turnoFechamento.finalizado) ? Icons.check : Icons.cancel_outlined, tarefas_turno_3),
                                         ],
                                       )

                                     ],
                                   )
                               );

                            }
                      });
                 });
  }
  Widget _DrawerTitle(BuildContext context, IconData icon, String text){

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
         setState(() {
           turno = text;
         });
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(icon,
              size: 32.0,
              color: Colors.white
              ),
              SizedBox(width: 32.0,),
              Text(text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white
                )
              ),


            ],
          ),
        ),
      )
    );
  }
  Widget _tarefaContainer (BuildContext context, int index){

    if(_turno == tarefas_turno_2 && (index == 2 || index == 4) ){
      return ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return Padding(
              padding: EdgeInsets.only(right: 20.0,left: 20.0, top: 10.0, bottom: 10.0),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(value: tarefas[index].finalizada,
                            onChanged: (value){setState (() {
                              if(tarefas[index].comentario == "" ||
                                  (!disabledIconComent(index, tarefas[index]) && tarefas[index].comentario == "") ||
                                  (!disabledIconCamera(index,tarefas[index]) && tarefas[index].fileimg == null)
                              ){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content:  Text("Responda a pergunta antes de finalizar!",
                                    textAlign: TextAlign.center,),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.redAccent,
                                ));
                              }else{
                                if(!tarefas[index].finalizada){
                                  tarefas[index].finalizada = true;//seta
                                }else{
                                  tarefas[index].finalizada = false;//seta
                                }
                              }

                              if(tarefas.length == isFinished()){
                                showFinishDialog(context, model);
                              }

                            });
                            },
                            shape: CircleBorder(
                              side: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.purple
                              ),
                            ),
                            checkColor: Colors.purple,
                            activeColor: Colors.white,),
                          Expanded(
                            child:Text(tarefas[index].pergunta),
                          )
                        ],

                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                          Container(
                            width: MediaQuery.of(context).size.width/5,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(50)
                                ),
                                color: (tarefas[index].finalizada ? Color.fromRGBO(224, 193, 247, 150): Color.fromRGBO(224, 193, 247, 100))
                            ),
                            child: Center(
                              child: IconButton(onPressed: (){
                                  showComentsDialog(context,tarefas[index]);
                              },
                                color:  tarefas[index].finalizada ? Color.fromRGBO(139, 5, 242, 200): Colors.purple,
                                disabledColor: Color.fromRGBO(139, 5, 242, 200),
                                icon: Icon(Icons.text_snippet),iconSize: 20.0,),
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 40)),
                          Container(
                            width: MediaQuery.of(context).size.width/5,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(50)
                              ),
                              color: disabledIconCamera(index,tarefas[index]) ? Color.fromRGBO(224, 193, 247, 150):
                              (tarefas[index].finalizada ? Color.fromRGBO(224, 193, 247, 150): Color.fromRGBO(224, 193, 247, 100)),
                            ),
                            child: Center(
                              child:  IconButton(onPressed: disabledIconCamera(index,tarefas[index]) ? null : ()async{

                                if(tarefas[index].finalizada ){
                                  return null;
                                }else{
                                  if(tarefas[index].fileimg==null)
                                    showPicker(context, tarefas[index]);
                                  else
                                    showImageDialog(context,tarefas[index]);
                                }
                              },
                                disabledColor: Color.fromRGBO(139, 5, 242, 200),
                                color: tarefas[index].finalizada ? Color.fromRGBO(139, 5, 242, 200): Colors.purple,
                                icon: Icon(Icons.camera_alt_outlined),iconSize: 20.0,),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
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
                height: 164,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(value:tarefas[index].finalizada,
                                onChanged: (value){setState (() {
                                  if(tarefas[index].resposta == "" ||
                                      (!disabledIconComent(index, tarefas[index]) && tarefas[index].comentario == "") ||
                                      (!disabledIconCamera(index,tarefas[index]) && tarefas[index].fileimg == null)
                                  ){
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content:  Text("Responda a pergunta antes de finalizar!",
                                        textAlign: TextAlign.center,),
                                      duration: Duration(seconds: 1),
                                      backgroundColor: Colors.redAccent,
                                    ));
                                  }else{
                                    if(!tarefas[index].finalizada){
                                      tarefas[index].finalizada = true;//seta
                                    }else{
                                      tarefas[index].finalizada = false;//seta
                                    }
                                  }

                                  if(tarefas.length == isFinished()){
                                    showFinishDialog(context, model);
                                  }

                                });
                                },
                                shape: CircleBorder(
                                  side: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.purple
                                  ),
                                ),
                                checkColor: Colors.purple,
                                activeColor: Colors.white,),
                              Expanded(
                                child:Text(tarefas[index].pergunta),
                              )
                            ],

                          ),
                          Row(children: <Widget>[
                            Checkbox(value:checkYes(tarefas[index].resposta),
                              onChanged: (value){setState (() {
                                if(tarefas[index].resposta == "sim"){
                                  tarefas[index].resposta = "";//seta
                                  tarefas[index].finalizada = false;//a pergunta não pode estar finalizada
                                }else {
                                  tarefas[index].resposta = "sim" ;//seta
                                  tarefas[index].finalizada = false;
                                }
                              });
                              },
                              shape: CircleBorder(),
                              checkColor: Colors.purple,
                              activeColor: Colors.white,),
                            Expanded(
                              child: Text("Sim"),
                            ),
                            Checkbox(value: checkNo(tarefas[index].resposta),
                              onChanged: (value){setState (() {
                                if(tarefas[index].resposta == "não"){
                                  tarefas[index].resposta = "";//seta
                                  tarefas[index].finalizada = false;//a pergunta não pode estar finalizada
                                }else{
                                  tarefas[index].resposta = "não";//seta
                                  tarefas[index].finalizada = false;
                                }
                              });
                              },
                              shape: CircleBorder(
                              ),
                              checkColor: Colors.purple,
                              activeColor: Colors.white,),
                            Expanded(
                              child: Text("Não"),
                            ),

                          ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                              Container(
                                width: MediaQuery.of(context).size.width/5,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50)
                                    ),
                                    color: disabledIconComent(index,tarefas[index]) ? Color.fromRGBO(224, 193, 247, 150):
                                    (tarefas[index].finalizada ? Color.fromRGBO(224, 193, 247, 150): Color.fromRGBO(224, 193, 247, 100))
                                ),
                                child: Center(
                                  child: IconButton(onPressed: disabledIconComent(index, tarefas[index]) ? null: (){
                                    if(tarefas[index].finalizada){
                                      return null;
                                    }else{
                                      showComentsDialog(context,tarefas[index]);
                                    }
                                  },
                                    color:  tarefas[index].finalizada? Color.fromRGBO(139, 5, 242, 200): Colors.purple,
                                    disabledColor: Color.fromRGBO(139, 5, 242, 200),
                                    icon: Icon(Icons.text_snippet),iconSize: 20.0,),
                                ),
                              ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 40)),
                              Container(
                                width: MediaQuery.of(context).size.width/5,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(50)
                                  ),
                                  color: disabledIconCamera(index,tarefas[index]) ? Color.fromRGBO(224, 193, 247, 150):
                                  (tarefas[index].finalizada ? Color.fromRGBO(224, 193, 247, 150): Color.fromRGBO(224, 193, 247, 100)),
                                ),
                                child: Center(
                                  child:  IconButton(onPressed: disabledIconCamera(index,tarefas[index]) ? null : ()async{

                                    if(tarefas[index].finalizada ){
                                      return null;
                                    }else{
                                      if(tarefas[index].fileimg==null)
                                        showPicker(context, tarefas[index]);
                                      else
                                        showImageDialog(context,tarefas[index]);
                                    }
                                  },
                                    disabledColor: Color.fromRGBO(139, 5, 242, 200),
                                    color: tarefas[index].finalizada ? Color.fromRGBO(139, 5, 242, 200): Colors.purple,
                                    icon: Icon(Icons.camera_alt_outlined),iconSize: 20.0,),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                ),
              ),
            );

          });
    }

  }



  Future<Null> imageFromCamera(Tarefa tarefa,) async {

    final PickedFile? fileImage = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 50);
    if(fileImage != null) {
      _image = File(fileImage.path);
      tarefa.fileimg = fileImage;
    }

  }
  Future<Null> imageFromGallery(Tarefa tarefa,) async {

    final PickedFile? fileImage = await ImagePicker().getImage(source: ImageSource.gallery, imageQuality: 50);
    if(fileImage != null) {
      _image = File(fileImage.path);
      tarefa.fileimg = fileImage;
    }

  }
  void showPicker(context,tarefa){
    showModalBottomSheet(context: context, builder: (BuildContext context){
      return SafeArea(child: Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("Galeria"),
            onTap: (){
              imageFromGallery(tarefa);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt_outlined),
            title: Text("Câmera"),
            onTap: (){
              imageFromCamera(tarefa);
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
    });
  }


  bool disabledIconCamera(int index, Tarefa tarefa){

    if(_turno == tarefas_turno_1){
      if(index == 2 || index == 12 ){
        if(tarefa.resposta == "não")
          return true;
        return false;
      }
      return true;
    }else if(_turno == tarefas_turno_2){
      if(index == 4 ){
        if(tarefa.resposta == "não")
          return true;
        return false;
      }
      return true;

    }else if(_turno == tarefas_turno_3){
      return true;
    }
    return true;
  }
  bool disabledIconComent(int index, Tarefa tarefa){

    if(_turno == tarefas_turno_1){
      if((index == 3  || index == 8|| index == 9 || index == 10 || index == 11) && tarefa.resposta == "não"){
        return false;
      }else if(index == 7 && tarefa.resposta == "sim"){
        return false;
      }
      return true;
    }else if(_turno == tarefas_turno_2){
      if(index == 1 && tarefa.resposta == "não"){
        return false;
      }
      return true;

    }else if(_turno == tarefas_turno_3){
      return true;
    }
    return true;
  }
  bool checkYes(String check){
    if(check == "sim") {
      return true;
    }else if(String == "") {
      return false;
    }
    return false;

  }
  bool checkNo(String check){
    if(check == "não") {
      return true;
    }else if(check == "") {
      return false;
    }
    return false;
  }
  int isFinished(){

    int finished = 0;
    for (int i=0; i<tarefas.length;i++){
      if(tarefas[i].finalizada == true){
        finished++;
      }
    }
    return finished;
  }
  String intToString(int num){
    String aux = '$num';
    return aux;
  }
  Future<Null> saveData(String uid,String turno) async {
    var now = DateTime.now();
    String day = now.day.toString();
    //String day = 11.toString();
    String month = now.month.toString();
    //String month = 10.toString();
    String year = now.year.toString();
    //String year = 2020.toString();

    if (turno == tarefas_turno_1) {

      for (int i = 0; i < _TarefasManha.length; i++) {

        if(_TarefasManha[i].fileimg != null) {
          if(i==2){
            _image_1 = File(_TarefasManha[i].fileimg.path);
            UploadTask task = FirebaseStorage.instance.ref().child(DateTime.now().millisecondsSinceEpoch.toString()).
            putFile(_image_1);
            TaskSnapshot taskSnapshot = await task.whenComplete(() => null);
            String url = await taskSnapshot.ref.getDownloadURL();
            _TarefasManha[i].urlimg = url;
          }else{
            _image_2 = File(_TarefasManha[i].fileimg.path);
            UploadTask task = FirebaseStorage.instance.ref().child(DateTime.now().millisecondsSinceEpoch.toString()).
            putFile(_image_2);
            TaskSnapshot taskSnapshot = await task.whenComplete(() => null);
            String url = await taskSnapshot.ref.getDownloadURL();
            _TarefasManha[i].urlimg = url;
          }
        }
        if(i > 9){
          await FirebaseFirestore.instance.collection("USUARIO").doc(uid).
          collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
          collection("TAREFAS_MANHÃ").doc("tarefa_manha_"+i.toString()).
          set(_TarefasManha[i].toMap());
        }else{
          await FirebaseFirestore.instance.collection("USUARIO").doc(uid).
          collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
          collection("TAREFAS_MANHÃ").doc("tarefa_manha_0"+i.toString()).
          set(_TarefasManha[i].toMap());
        }

      }
    } else if (turno == tarefas_turno_2) {

      for (int i = 0; i < _TarefasIntermediario.length; i++) {

        if(_TarefasIntermediario[i].fileimg != null) {
          _image = File(_TarefasIntermediario[i].fileimg.path);
          UploadTask task = FirebaseStorage.instance.ref().child(DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()).
          putFile(_image);
          TaskSnapshot taskSnapshot = await task.whenComplete(() => null);
          String url = await taskSnapshot.ref.getDownloadURL();
          _TarefasIntermediario[i].urlimg = url;
        }
        await FirebaseFirestore.instance.collection("USUARIO").doc(uid).
        collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
        collection("TAREFAS_INTERMEDIÁRIO").doc(
            "tarefa_intermediario_" + i.toString()).
        set(_TarefasIntermediario[i].toMap());
      }

    }else if(turno == tarefas_turno_3){

      for (int i = 0; i < _TarefasFechamento.length; i++) {

        await FirebaseFirestore.instance.collection("USUARIO").doc(uid).
        collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
        collection("TAREFAS_FECHAMENTO").doc(
            "tarefa_fechamento_" + i.toString()).
        set(_TarefasFechamento[i].toMap());
      }
    }
  }
}











































































































