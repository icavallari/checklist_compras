import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/lista.dart';
import '../pages/produtos.dart';

class ListaWidget extends StatelessWidget {
  final Function onRemove;
  final Lista item;

  const ListaWidget({
    Key key,
    this.item,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(item),
      background: _backgroundDismiss(CupertinoIcons.trash, Colors.red,
          MainAxisAlignment.start, "Excluir lista"),
      secondaryBackground: _backgroundDismiss(CupertinoIcons.doc_on_doc,
          Colors.green, MainAxisAlignment.end, "Duplicar lista"),
      onDismissed: (direction) {
        onRemove(this.item);
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProdutoScreen(listaId: item.id)),
          );
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: 7,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black26),
          ),
          child: ListTile(
            leading: Icon(
              CupertinoIcons.cart_badge_plus,
              //  : CupertinoIcons.cart,
            ),
            title: Text(item.nome),
            subtitle: Text(item.dataCriacao + "h"),
            trailing: Icon(
              CupertinoIcons.chevron_compact_right,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _backgroundDismiss(
    IconData iconData, Color color, MainAxisAlignment alignment, String label) {
  return Container(
    alignment: Alignment.centerRight,
    margin: EdgeInsets.only(
      bottom: 13,
      top: 7,
    ),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: alignment,
      children: _linha(alignment, iconData, label),
    ),
  );
}

List<Widget> _linha(
    MainAxisAlignment alignment, IconData iconData, String label) {
  List<Widget> itens = [
    Text(
      label,
      style: TextStyle(fontSize: 17, color: Colors.white),
    )
  ];

  itens.insert(
      MainAxisAlignment.start != alignment ? 1 : 0, _iconLabel(iconData));

  return itens;
}

Widget _iconLabel(IconData iconData) {
  return Padding(
    padding: EdgeInsets.only(
      left: 15,
      right: 15,
    ),
    child: Icon(
      iconData,
      color: Colors.white,
    ),
  );
}
