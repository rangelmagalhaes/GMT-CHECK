import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gmtchecklist/helpers/tarefa_helper.dart';

class TaskData{

  String category ="";
  String id="";

  String comentario="";
  bool finalizada = false;
  String pergunta="";
  String resposta="";
  String url_img="";

  TaskData.fromDocument(DocumentSnapshot  snapshot){
    Map<String, dynamic> map = ( snapshot.data()!) as Map<String, dynamic>;
    id = snapshot.id;
    comentario = map["comentario"];
    finalizada = map["finalizada"];
    pergunta = map["pergunta"];
    resposta = map["resposta"];
    url_img = map["urlimg"];
  }

  List<DocumentSnapshot> fromQuery(QuerySnapshot  snapshot){
    return snapshot.docs;
  }



}