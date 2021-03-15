import 'dart:async';

import 'package:app1/src/models/listacompra_model.dart';
import 'package:app1/src/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class BlocListas {
  final repo = Repository();

  final _ctrl = PublishSubject<List<ListaCompraModel>>();

  Stream<List<ListaCompraModel>> get stream => _ctrl.stream;

  BlocListas() {
    load();
  }

  load() async {
    _ctrl.sink.add(await repo.getListas());
  }

  void adicionar(String titulo) {
    repo.salvarLista(
      ListaCompraModel(
        nome: titulo,
      ),
    );
    load();
  }

  void remover(ListaCompraModel item) {
    item.deletado = true;
    repo.atualizarLista(item);
    load();
  }

  fecharStream() {
    _ctrl.close();
  }
}
