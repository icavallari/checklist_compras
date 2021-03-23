class Item {
  int id;
  int qtd;
  int ordem;
  String nome;
  double valor;
  bool deletado;
  bool noCarinho;
  int listaCompraId;

  Item({
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
      "nocarrinho": noCarinho,
      "listacompra_id": listaCompraId
    };
    if (id != null) map['id'] = id;
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    qtd = map['qtd'];
    nome = map['nome'];
    ordem = map['ordem'];
    valor = map['valor'];
    deletado = map['deletado'] != 0;
    noCarinho = map['nocarrinho'] != 0;
    listaCompraId = map['listacompra_id'];
  }
}
