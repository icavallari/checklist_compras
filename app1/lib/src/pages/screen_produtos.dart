import 'package:app1/src/block/service_listas.dart';
import 'package:app1/src/block/service_produtos.dart';
import 'package:app1/src/component/comp_alert.dart';
import 'package:app1/src/component/comp_headerpath.dart';
import 'package:app1/src/component/comp_produto.dart';
import 'package:app1/src/models/itemcompra_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Produtos extends StatefulWidget {
  final int listaId;

  Produtos({Key key, this.listaId}) : super(key: key);

  @override
  _ProdutosState createState() => _ProdutosState(listaId);
}

class _ProdutosState extends State<Produtos> {
  final int listaId;
  _ProdutosState(this.listaId);

  Alert _alert;
  ProdutoService _service;
  ListaService _listaService;

  @override
  void initState() {
    super.initState();

    _listaService = ListaService();
    _listaService.loadTitulo(listaId);
    _service = ProdutoService(listaId);

    _alert = Alert(
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
          HeaderPath(
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
                      builder: (context,
                          AsyncSnapshot<List<ItemCompraModel>> snapshot) {
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

  Widget _buildList(ProdutoService service, List<ItemCompraModel> itens) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: itens == null ? 0 : itens.length,
      itemBuilder: (context, index) {
        return ProdutoItem(
          key: Key("$index"),
          item: itens[index],
          onRemove: (ItemCompraModel m) {
            service.remover(m);
          },
        );
      },
    );
  }
}
