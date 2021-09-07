import 'package:app1/src/widget/headerpath.dart';
import 'package:app1/src/widget/produto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../service/service_listas.dart';
import '../service/service_produtos.dart';
import '../widget/produto.dart';
import '../widget/alert_produto.dart';

class ProdutoScreen extends StatefulWidget {
  final int listaId;

  ProdutoScreen({Key key, this.listaId}) : super(key: key);

  @override
  _ProdutoScreenState createState() => _ProdutoScreenState(listaId);
}

class _ProdutoScreenState extends State<ProdutoScreen> {
  final int listaId;
  _ProdutoScreenState(this.listaId);

  AlertProdutoWidget _alert;
  ProdutoService _service;
  ListaService _listaService;

  @override
  void initState() {
    super.initState();

    _listaService = ListaService();
    _listaService.loadTitulo(listaId);
    _service = ProdutoService(listaId);

    _alert = AlertProdutoWidget(
      context: context,
      okClick: (String titulo) {
        _service.adicionar(
          titulo,
        );
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          HeaderPathWidget(
            colors1: Colors.green[200],
            colors2: Colors.green,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                CupertinoIcons.chevron_back,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            StreamBuilder(
                              stream: _listaService.streamTitulo,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                return Text(
                                  snapshot.data == null ? "..." : snapshot.data,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        RaisedButton.icon(
                          icon: Icon(
                            CupertinoIcons.add,
                          ),
                          onPressed: () {
                            _alert.show();
                          },
                          label: Text("Produto"),
                          color: Colors.white,
                          textColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    StreamBuilder(
                      stream: _service.stream,
                      builder: (context, AsyncSnapshot<List<Item>> snapshot) {
                        return _buildList(_service, snapshot.data);
                      },
                    ),
                  ],
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(ProdutoService service, List<Item> itens) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: itens == null ? 0 : itens.length,
      itemBuilder: (context, index) {
        return ProdutoWidget(
          key: Key("$index"),
          item: itens[index],
          onRemove: (Item m) {
            service.remover(m);
          },
        );
      },
    );
  }
}
