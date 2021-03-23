import 'package:intl/intl.dart';

class Lista {
  int id;
  String nome;
  int qtdItens;
  bool deletado;
  String dataCriacao;

  Lista({
    this.id,
    this.nome,
    this.deletado = false,
    this.qtdItens,
    this.dataCriacao,
  }) {
    if (dataCriacao == null) {
      dataCriacao = DateFormat('dd/MM/yy kk:mm').format(DateTime.now());
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "nome": nome,
      "deletado": deletado,
      "datacriacao": dataCriacao
    };
    if (id != null) map['id'] = id;
    return map;
  }

  Lista.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    qtdItens = map['qtditens'];
    deletado = map['deletado'] != 0;
    dataCriacao = map['datacriacao'];
  }
}
