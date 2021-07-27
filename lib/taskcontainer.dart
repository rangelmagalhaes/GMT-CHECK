import 'package:flutter/cupertino.dart';
import 'package:gmtchecklist/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'datas/task_data.dart';
import 'helpers/tarefa_helper.dart';

class TaskContainer extends StatefulWidget {

  final String turno;
  final TaskData task;

  TaskContainer( this.turno, this.task);

  @override
  _TaskContainerState createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {

  static final String tarefas_turno_1 = "Tarefas Manhã";
  static final String tarefas_turno_2 = "Tarefas Intermediário";
  static final String tarefas_turno_3 = "Tarefas Fechamento";

  @override
  Widget build(BuildContext context) {

      return Container();
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
  String intToString(int num){
    String aux = '$num';
    return aux;
  }
}
