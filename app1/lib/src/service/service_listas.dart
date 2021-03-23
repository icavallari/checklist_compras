import 'dart:async';

import 'package:app1/src/models/listacompra_model.dart';
import 'package:app1/src/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

class ListaService {
  final repo = Repository();

  final _ctrlTitulo = PublishSubject<String>();
  final _ctrl = PublishSubject<List<ListaCompraModel>>();

  Stream<String> get streamTitulo => _ctrlTitulo.stream;
  Stream<List<ListaCompraModel>> get stream => _ctrl.stream;

  loadListas() async {
    _ctrl.sink.add(await repo.getListas());
  }

  loadTitulo(int id) async {
    ListaCompraModel model = await repo.getLista(id);
    _ctrlTitulo.sink.add(model.nome);
  }

  void adicionar(String titulo) {
    repo.salvarLista(
      ListaCompraModel(
        nome: titulo,
      ),
    );
    loadListas();
  }

  void remover(ListaCompraModel item) {
    item.deletado = true;
    repo.atualizarLista(item);
    loadListas();
  }

  fecharStream() {
    _ctrl.close();
    _ctrlTitulo.close();
  }
}
