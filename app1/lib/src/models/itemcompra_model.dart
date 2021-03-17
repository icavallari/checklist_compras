class ItemCompraModel {
  int id;
  int qtd;
  int ordem;
  String nome;
  double valor;
  bool deletado;
  bool noCarinho;
  int listaCompraId;

  ItemCompraModel({
    this.id,
    this.qtd,
    this.nome,
    this.ordem,
    this.valor,
    this.deletado = false,
    this.listaCompraId,
    this.noCarinho = false,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "qtd": qtd,
      "nome": nome,
      "ordem": ordem,
      "valor": valor,
      "deletado": deletado,
      "nocarinho": noCarinho,
      "listacompra_id": listaCompraId
    };
    if (id != null) map['id'] = id;
    return map;
  }

  ItemCompraModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    qtd = map['qtd'];
    nome = map['nome'];
    ordem = map['ordem'];
    valor = map['valor'];
    deletado = map['deletado'] == 0;
    noCarinho = map['nocarinho'] == 0;
    listaCompraId = map['listacompra_id'];
  }
}
