import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gmtchecklist/datas/task_data.dart';
import 'package:gmtchecklist/models/user_model.dart';
import 'package:gmtchecklist/screens/listView_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import '../tasktab.dart';



class ReportScreenInc extends StatefulWidget {
  const ReportScreenInc({Key? key}) : super(key: key);


  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<ReportScreenInc> {


  static final String tarefas_turno_1 = "Tarefas Manhã";
  static final String tarefas_turno_2 = "Tarefas Intermediário";
  static final String tarefas_turno_3 = "Tarefas Fechamento";

  String _loja = "OURO PRETO";
  String _uid = "JYMTZKONGIM4H1suGVz9pEold412";
  String day = "";
  String month = "";
  String year = "";

  get themeData => null;

  @override
  void initState() {
    // TODO: implement initState
    //implementar em caso de atualização da lista
    super.initState();

    var now = DateTime.now();
    day = now.day.toString();
    month = now.month.toString();
    year = now.year.toString();

  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return WillPopScope(
              onWillPop:() async => false,
              child:DefaultTabController(
                length: 3,
                child: Scaffold(
                    appBar:  AppBar(
                      actions: [
                        IconButton(onPressed: ()async{
                          DateTime? data = await showDatePicker(
                              context: context,
                              initialDate: DateTime(int.parse(year),int.parse(month),int.parse(day)),
                              firstDate: DateTime.utc(DateTime.now().year,DateTime.now().month ==1? 12:DateTime.now().month-1, DateTime.now().day),
                              lastDate: DateTime.now(),
                              builder:(context,child) {
                                return Theme(
                                  data: ThemeData.from(
                                    colorScheme: ColorScheme(
                                        primary: Color(0xFF8b05f2),
                                        primaryVariant:Color(0xFFa95ae6),
                                        secondary: Color(0xFF8b05f2)
                                        secondaryVariant: Color(0xFFa95ae6),
                                    surface: Color(0xFF8b05f2),
                                    background: Colors.white,
                                    error: Colors.red,
                                    onPrimary: Colors.white,
                                    onSecondary: Colors.white,
                                    onSurface: Colors.black,
                                    onBackground: Color(0xFF8b05f2),
                                    onError: Colors.red,
                                    brightness: Brightness.light,

                                  ),
                                ),
                                child: child!,
                                );
                              }
                          );
                          if(data!=null){
                            setState(() {
                              day = data.day.toString();
                              month = data.month.toString();
                              year = data.year.toString();
                            });
                          }
                        },
                          icon: Icon(Icons.calendar_today_rounded),
                          iconSize: 20.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                      ],
                      title: Text(_loja),
                      centerTitle: true,
                      toolbarHeight: 110,
                      backgroundColor: Color(0xFF8b05f2),
                      elevation: 0.0,
                      bottom: TabBar(
                        indicatorColor: Colors.white,
                        tabs: <Widget>[
                          Tab(text: "Manhã"),
                          Tab(text: "Intermediário"),
                          Tab(text: "Fechamento"),
                        ],
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      child: TabBarView(
                        children:<Widget>[
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("USUARIO").doc(_uid).
                              collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
                              collection("TAREFAS_MANHÃ").snapshots(),
                              builder: (context,snapshot){
                                switch(snapshot.connectionState){
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Center(child: CircularProgressIndicator(color: Color(0xFF8b05f2),),);
                                  default:
                                    return Expanded(
                                      child:ListView.builder(itemBuilder:(context,index){

                                        return TaskTab( tarefas_turno_1,TaskData.fromDocument(snapshot.requireData.docs[index]));
                                      },
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.requireData.docs.length,),
                                    );
                                }
                              }),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("USUARIO").doc(_uid).
                              collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
                              collection("TAREFAS_INTERMEDIÁRIO").snapshots(),
                              builder: (context,snapshot){
                                switch(snapshot.connectionState){
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Center(child: CircularProgressIndicator(color: Color(0xFF8b05f2),),);
                                  default:
                                    return Expanded(
                                      child:ListView.builder(itemBuilder:(context,index){

                                        return TaskTab( tarefas_turno_2,TaskData.fromDocument(snapshot.requireData.docs[index]));
                                      },
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.requireData.docs.length,),
                                    );
                                }
                              }),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("USUARIO").doc(_uid).
                              collection("TAREFAS").doc("tarefas_" + year + "_" +((int.parse(month)<10)?("0"+month):(month)) + "_" + ((int.parse(day)<10)?("0"+day):(day))).
                              collection("TAREFAS_FECHAMENTO").snapshots(),
                              builder: (context,snapshot){
                                switch(snapshot.connectionState){
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Center(child: CircularProgressIndicator(color: Color(0xFF8b05f2),),);
                                  default:
                                    return Expanded(
                                      child:ListView.builder(itemBuilder:(context,index){

                                        return TaskTab( tarefas_turno_3,TaskData.fromDocument(snapshot.requireData.docs[index]));
                                      },
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.requireData.docs.length,),
                                    );
                                }
                              }),
                        ],
                      ),
                    ),
                    drawer: Drawer(child: _customDrawerInconfidentes(context, model.firebaseUser.uid),)
                ),
              ),);
        });
  }
  Widget _customDrawerInconfidentes(BuildContext context, String gerente_uid){


    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("LOJAS").get(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(color: Color(0xFF8b05f2),),);
          }else{
            return ScopedModelDescendant<UserModel>(builder: (context,child,model){
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
                            ],
                          ),
                        ),
                      ),
                      ListView(
                        padding: EdgeInsets.only(left: 32.0, top: 16.0,right: 16.0),
                        children: < Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 4.0),
                            padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 0.0),
                            height: 170.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  top:20.0,
                                  left:0.0,
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
                                  bottom:0.0,
                                  left:0.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance.collection("USUARIO").doc(gerente_uid).get(),
                                          builder: (context, snapshot1) {
                                            if (!snapshot1.hasData) {
                                              return Text("Olá,",
                                                // testando pegar do e-mail
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.white
                                                ),
                                              );
                                            } else {
                                              return Row(
                                                children: [
                                                  Text("Olá, " + snapshot1.requireData["gerente"],
                                                    // testando pegar do e-mail
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontStyle: FontStyle.italic,
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                  SizedBox(width: 25,),
                                                  IconButton(onPressed: (){
                                                    Navigator.of(context).pop();
                                                    model.signOut(context);
                                                  },
                                                      icon: Icon(Icons.logout,
                                                        color: Colors.white,)),
                                                ],
                                              );
                                            }
                                          }),
                                      SizedBox(height: 4.0,),
                                      Text(
                                        "INCONFIDENTES",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontStyle: FontStyle.italic,
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
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(3)["nome"],snapshot.requireData.docs.elementAt(3)["gerente_uid"]),
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(4)["nome"],snapshot.requireData.docs.elementAt(4)["gerente_uid"]),
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(5)["nome"],snapshot.requireData.docs.elementAt(5)["gerente_uid"]),
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(6)["nome"],snapshot.requireData.docs.elementAt(6)["gerente_uid"]),
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(7)["nome"],snapshot.requireData.docs.elementAt(7)["gerente_uid"]),
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(8)["nome"],snapshot.requireData.docs.elementAt(8)["gerente_uid"]),
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(9)["nome"],snapshot.requireData.docs.elementAt(9)["gerente_uid"]),
                          _DrawerTitle(context,snapshot.requireData.docs.elementAt(13)["nome"],snapshot.requireData.docs.elementAt(13)["gerente_uid"]),
                        ],
                      )

                    ],
                  )
              );
            });
          }
        });
  }
  Widget _DrawerTitle(BuildContext context,String text, String uid){

    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (){
            Navigator.of(context).pop();
            setState(() {
              _loja = text;
              _uid = uid;
            });
          },
          child: Container(
            height: 60.0,
            child: Row(
              children: [
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

}
