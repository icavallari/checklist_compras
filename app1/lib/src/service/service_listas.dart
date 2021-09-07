import 'dart:async';

import 'package:app1/src/repo/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../models/lista.dart';

class ListaService {
  final repo = Repository();

  final _ctrlTitulo = PublishSubject<String>();
  final _ctrl = PublishSubject<List<Lista>>();

  Stream<String> get streamTitulo => _ctrlTitulo.stream;
  Stream<List<Lista>> get stream => _ctrl.stream;

  loadListas() async {
    _ctrl.sink.add(await repo.getListas());
  }

  loadTitulo(int id) async {
    Lista model = await repo.getLista(id);
    _ctrlTitulo.sink.add(model.nome);
  }

  void adicionar(String titulo) {
    repo.salvarLista(
      Lista(
        nome: titulo,
      ),
    );
    loadListas();
  }

  void remover(Lista item) {
    item.deletado = true;
    repo.atualizarLista(item);
    loadListas();
  }

  fecharStream() {
    _ctrl.close();
    _ctrlTitulo.close();
  }
}
