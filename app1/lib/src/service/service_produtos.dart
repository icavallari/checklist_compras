import 'dart:async';

import 'package:app1/src/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/item.dart';

class ProdutoService {
  final int listaId;
  int _lastOrdem = 0;
  final repo = Repository();
  final _ctrl = PublishSubject<List<Item>>();

  Stream<List<Item>> get stream => _ctrl.stream;

  ProdutoService(this.listaId) {
    load();
  }

  load() async {
    _ctrl.sink.add(await repo.getItens(listaId));
  }

  void adicionar(String nome) {
    repo.salvarItem(
      Item(
        listaCompraId: listaId,
        ordem: _lastOrdem,
        nome: nome,
      ),
    );
    load();
  }

  void remover(Item item) {
    item.deletado = true;
    repo.atualizarItem(item);
    load();
  }

  fecharStream() {
    _ctrl.close();
  }
}
