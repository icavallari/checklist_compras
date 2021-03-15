import 'package:app1/src/models/listacompra_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app1/constants.dart';

class ListaCompraItem extends StatelessWidget {
  final Function onClick;
  final Function onRemove;
  final ListaCompraModel item;

  const ListaCompraItem({
    Key key,
    this.item,
    this.onClick,
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
      child: Container(
        margin: EdgeInsets.only(
          bottom: 7,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            CupertinoIcons.cart_badge_plus,
            //  : CupertinoIcons.cart,
          ),
          title: Text(item.nome),
          subtitle: Text(item.dataCriacao),
          trailing: Icon(
            CupertinoIcons.chevron_compact_right,
            size: 22,
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
