import 'package:app1/constants.dart';
import 'package:app1/src/widget/headerpath.dart';
import 'package:app1/src/widget/alert_lista.dart';
import 'package:app1/src/widget/lista.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/bannerads.dart';
import '../models/lista.dart';
import '../service/service_listas.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final blocListas = ListaService();
  AlertListaWidget alert;

  @override
  void initState() {
    super.initState();
    blocListas.loadListas();

    alert = AlertListaWidget(
      context: context,
      okClick: (String titulo) {
        blocListas.adicionar(titulo);
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
            colors1: Colors.blue[200],
            colors2: Colors.blue,
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
                            Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Checklist - Compras",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        RaisedButton.icon(
                          icon: Icon(
                            CupertinoIcons.add,
                          ),
                          onPressed: () {
                            alert.show();
                          },
                          label: Text("Lista"),
                          color: Colors.white,
                          textColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    StreamBuilder(
                      stream: blocListas.stream,
                      builder: (context, AsyncSnapshot<List<Lista>> snapshot) {
                        return _buildList(blocListas, snapshot.data);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: BannerAdWidget(BAN_UNIT_ID),
        ),
      ),
    );
  }

  Widget _buildList(ListaService blocEx, List<Lista> data) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListaWidget(
          item: data[index],
          onRemove: (Lista m) {
            blocEx.remover(m);
          },
        );
      },
    );
  }
}
