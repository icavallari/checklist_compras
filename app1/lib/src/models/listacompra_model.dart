import 'package:intl/intl.dart';

class ListaCompraModel {
  int id;
  String nome;
  int qtdItens;
  bool deletado;
  String dataCriacao;

  ListaCompraModel({
    this.id,
    this.nome,
    this.deletado = false,
    this.qtdItens,
    this.dataCriacao,
  }) {
    if (dataCriacao == null) {
      dataCriacao = DateFormat('dd/MM/yy – kk:mm').format(DateTime.now());
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

  ListaCompraModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    deletado = map['deletado'];
    qtdItens = map['qtditens'];
    dataCriacao = map['datacriacao'];
  }
}
