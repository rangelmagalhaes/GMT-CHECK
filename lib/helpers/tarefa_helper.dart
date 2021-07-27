
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final String perguntaColumn = "pergunta";
final String respostaColumn = "resposta";
final String finalizadaColumn = "finalizada";
final String comentarioColumn = "comentario";
final String fileimgColumn = "fileimg";
final String urlimgColumn =  "urlimg";


class Tarefa{

  String _pergunta ;
  String _resposta ;
  bool _finalizada ;
  String _comentario;
  PickedFile? fileimg ;
  String _url_img;

  Tarefa(this._pergunta,this._resposta, this._finalizada,this._comentario,this.fileimg,this._url_img);

  fromMap(Map map){
    _pergunta = map[perguntaColumn];
    _resposta = map[respostaColumn];
    _finalizada = map[finalizadaColumn];
    _comentario = map[comentarioColumn];
    //fileimg = map[fileimgColumn];
    _url_img = map[urlimgColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      perguntaColumn: _pergunta,
      respostaColumn: _resposta,
      finalizadaColumn: _finalizada,
      comentarioColumn: _comentario,
      urlimgColumn: _url_img,

    };

    return map;
  }

  String get pergunta => _pergunta;
  String get resposta => _resposta;
  bool get finalizada => _finalizada;
  String get comentario => _comentario;
  String get urlimg => _url_img;
  //PickedFile? get imagem => _imagem;

  set pergunta(String pergunta){
    _pergunta = pergunta;
  }
  set resposta(String resposta){
    _resposta = resposta;
  }
  set finalizada(bool finalizada){
    _finalizada = finalizada;
  }
  set comentario(String comentario){
    _comentario = comentario;
  }
  set urlimg(String url){
    _url_img = url;
  }
  //set imagem(PickedFile imagem){
   // _imagem = imagem;
  //}


}

class TarefasHelper {

  TarefasHelper();

  List criarTarefasManha() {

    List tarefas_manha=[];

    Tarefa tarefa_manha_1= Tarefa("Televisões ligadas?","",false,"", null,"" );
    Tarefa tarefa_manha_2= Tarefa("Celulares degustador ligados?","",false,"",null,"");
    Tarefa tarefa_manha_3= Tarefa("Todos os espaços da vitrine com aparelhos?","",false,"",null,"");
    Tarefa tarefa_manha_4= Tarefa("Equipe 100% uniformizada?","",false,"", null,"");
    Tarefa tarefa_manha_5= Tarefa("Precificadores atualizados?","",false,"", null,"");
    Tarefa tarefa_manha_6= Tarefa("Ar condicionado ligado?","",false,"", null,"");
    Tarefa tarefa_manha_7= Tarefa("Lâmpadas acesas?","",false,"", null,"");
    Tarefa tarefa_manha_8= Tarefa("Alguma anomalia? (lâmpada queimada, ar condicionado com problemas, etc)","",false,"", null,"");
    Tarefa tarefa_manha_9= Tarefa("Bancadas limpas e sem nenhum objeto?","",false,"", null,"");
    Tarefa tarefa_manha_10= Tarefa("Lixeiras sem lixo e limpas?","",false,"", null,"");
    Tarefa tarefa_manha_11= Tarefa("PDV limpo?","",false,"", null,"");
    Tarefa tarefa_manha_12= Tarefa("Salão de vendas limpo?","",false,"", null,"");
    Tarefa tarefa_manha_13= Tarefa("Quadro de gestão à vista atualizado?","",false,"", null,"");
    Tarefa tarefa_manha_14= Tarefa("Matinal aplicada? (serviço, terminais, acessórios, "
        "seguros, prazo médio de recebimento)","",false,"", null,"");


    tarefas_manha.add(tarefa_manha_1);
    tarefas_manha.add(tarefa_manha_2);
    tarefas_manha.add(tarefa_manha_3);
    tarefas_manha.add(tarefa_manha_4);
    tarefas_manha.add(tarefa_manha_5);
    tarefas_manha.add(tarefa_manha_6);
    tarefas_manha.add(tarefa_manha_7);
    tarefas_manha.add(tarefa_manha_8);
    tarefas_manha.add(tarefa_manha_9);
    tarefas_manha.add(tarefa_manha_10);
    tarefas_manha.add(tarefa_manha_11);
    tarefas_manha.add(tarefa_manha_12);
    tarefas_manha.add(tarefa_manha_13);
    tarefas_manha.add(tarefa_manha_14);

    return tarefas_manha;
  }
  List criarTarefasIntermediario() {

    List tarefas_intermediario=[];

    Tarefa tarefa_intermediario_1= Tarefa("Mapa de PDV atualizado?","",false,"", null,"");
    Tarefa tarefa_intermediario_2= Tarefa("Contratos não digitalizados zerados?","",false,"", null,"");
    Tarefa tarefa_intermediario_3= Tarefa("Existem quantos contratos com irregularidade?","",false,"", null,"");
    Tarefa tarefa_intermediario_4= Tarefa("Depósito realizado?","",false,"", null,"");
    Tarefa tarefa_intermediario_5= Tarefa("Valor em caixa nesse momento frente ao Syscor:","",false,"", null,"");
    Tarefa tarefa_intermediario_6= Tarefa("Financeiras digitadas no GFin?","",false,"", null,"");
    Tarefa tarefa_intermediario_7= Tarefa("Faça a validação de todas as vendas do dia anterior - Syscor x Next/360 - Vendas validadas?","",false,"", null,"");
    Tarefa tarefa_intermediario_8= Tarefa("Todos os e-mails operacionais tratados? (Solicitações do bko)?","",false,"", null,"");


    tarefas_intermediario.add(tarefa_intermediario_1);
    tarefas_intermediario.add(tarefa_intermediario_2);
    tarefas_intermediario.add(tarefa_intermediario_3);
    tarefas_intermediario.add(tarefa_intermediario_4);
    tarefas_intermediario.add(tarefa_intermediario_5);
    tarefas_intermediario.add(tarefa_intermediario_6);
    tarefas_intermediario.add(tarefa_intermediario_7);
    tarefas_intermediario.add(tarefa_intermediario_8);


    return tarefas_intermediario;
  }
  List criarTarefasFechamento() {

    List tarefas_fechamento=[];

    Tarefa tarefa_fechamento_1= Tarefa("Caixa fechado?","",false,"", null,"");
    Tarefa tarefa_fechamento_2= Tarefa("Aparelhos fora da vitrine?","",false,"", null,"");
    Tarefa tarefa_fechamento_3= Tarefa("Televisores desligados?","",false,"", null,"");
    Tarefa tarefa_fechamento_4= Tarefa("Computadores guardados em local apropriado?","",false,"", null,"");
    Tarefa tarefa_fechamento_5= Tarefa("Ar condicionado desligado?","",false,"", null,"");
    Tarefa tarefa_fechamento_6= Tarefa("Alarme ativado?","",false,"", null,"");
    Tarefa tarefa_fechamento_7= Tarefa("Luzes apagadas?","",false,"", null,"");
    Tarefa tarefa_fechamento_8= Tarefa("Loja trancada?","",false,"", null,"");


    tarefas_fechamento.add(tarefa_fechamento_1);
    tarefas_fechamento.add(tarefa_fechamento_2);
    tarefas_fechamento.add(tarefa_fechamento_3);
    tarefas_fechamento.add(tarefa_fechamento_4);
    tarefas_fechamento.add(tarefa_fechamento_5);
    tarefas_fechamento.add(tarefa_fechamento_6);
    tarefas_fechamento.add(tarefa_fechamento_7);
    tarefas_fechamento.add(tarefa_fechamento_8);

    return tarefas_fechamento;
  }

}