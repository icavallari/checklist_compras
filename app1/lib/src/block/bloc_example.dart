import 'dart:async';

import 'package:app1/src/models/litacompra_model.dart';
import 'package:rxdart/rxdart.dart';

class BlocExample {
  List<ListaCompraModel> _itens = [];

  final _blocController = PublishSubject<List<ListaCompraModel>>();

  Stream<List<ListaCompraModel>> get stream => _blocController.stream;

  void adicionar() {
    var total = _itens.length + 1;
    var listaCompraModel = ListaCompraModel(
      id: _itens.length,
      nome: "Lista de Compras $total",
      possuiItens: _itens.length % 2 == 0,
    );
    _itens.insert(0, listaCompraModel);
    _blocController.sink.add(_itens);
  }

  void remover(ListaCompraModel item) {
    _itens.remove(item);
    _blocController.sink.add(_itens);
  }

  fecharStream() {
    _blocController.close();
  }
}
