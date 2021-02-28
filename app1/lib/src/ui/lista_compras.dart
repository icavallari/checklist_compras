import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app1/constants.dart';

class ListaCompraItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool containsItens;

  const ListaCompraItem({
    Key key,
    this.title,
    this.subTitle,
    this.containsItens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
//https://blog.usejournal.com/implementing-swipe-to-delete-in-flutter-a742e041c5dd
// swipe to delete

// talvez load ao clicar nova lista
    return Container(
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
          containsItens == true
              ? CupertinoIcons.cart_badge_plus
              : CupertinoIcons.cart,
        ),
        title: Text(title),
        subtitle: Text(subTitle),
        trailing: Icon(
          CupertinoIcons.chevron_compact_right,
          size: 22,
        ),
      ),
    );
  }
}
