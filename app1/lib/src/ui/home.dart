import 'package:app1/src/block/bloc_example.dart';
import 'package:app1/src/models/litacompra_model.dart';
import 'package:app1/src/ui/lista_compras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'banner_ads.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title = "Flutter Demo Home Page";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final blocEx = BlocExample();

  //static const _adUnitID = "ca-app-pub-7121901221570106/8155541590";

//test
  static const _adUnitID = "ca-app-pub-3940256099942544/6300978111";

  final BannerAd myBanner = BannerAd(
    adUnitId: _adUnitID,
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(),
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: BezierClipper(),
            child: Container(
              height: size.height * .65,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue[200],
                    Colors.blue,
                  ],
                ),
                color: Colors.blue,
              ),
            ),
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
                              CupertinoIcons.doc_on_doc,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Listas",
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
                            blocEx.adicionar();
                          },
                          label: Text("Nova Lista"),
                          color: Colors.white,
                          textColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    StreamBuilder(
                      stream: blocEx.stream,
                      builder: (context,
                          AsyncSnapshot<List<ListaCompraModel>> snapshot) {
                        return _buildList(blocEx, snapshot.data);
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
          //border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: Center(
          child: BannerAdWidget(BannerAd.testAdUnitId),
        ),
      ),
    );
  }

  Widget _buildList(BlocExample blocEx, List<ListaCompraModel> data) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ListaCompraModel _item = data[index];
        return ListaCompraItem(
          item: _item,
          onClick: (ListaCompraModel m) => {},
          onRemove: (ListaCompraModel m) {
            blocEx.remover(m);
          },
        );
      },
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.85); //vertical line

    path.cubicTo(size.width / 3, size.height, 2 * size.width / 3,
        size.height * 0.4, size.width, size.height * 0.85);
    //cubic curve

    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
