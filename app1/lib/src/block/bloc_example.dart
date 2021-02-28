import 'dart:async';

import 'package:rxdart/rxdart.dart';

class BlocExample {
  List<String> _itens = [];

  //final _blocController = StreamController<List<String>>();
  final _blocController = PublishSubject<List<String>>();

  Stream<List<String>> get stream => _blocController.stream;

  void adicionar() {
    _itens.insert(0, "");
    _blocController.sink.add(_itens);
  }

  fecharStream() {
    _blocController.close();
  }
}
