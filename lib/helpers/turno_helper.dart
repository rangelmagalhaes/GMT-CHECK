class Turno{

  bool _finalizado;
  List _tarefas;


  Turno(this._finalizado,this._tarefas);


  bool get finalizado => _finalizado;
  List get tarefas=> _tarefas;

  set finalizado(bool finalizado){
    _finalizado = finalizado;
  }
  set tarefas(List tarefas){
    _tarefas = tarefas;
  }



}
