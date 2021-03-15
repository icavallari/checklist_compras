import 'package:flutter/material.dart';

class Alert {
  Function okClick;
  BuildContext context;

  Alert({
    this.okClick,
    this.context,
  });

  show() async {
    var txtController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nova Lista'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: txtController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Título",
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Criar'),
              onPressed: () {
                okClick(txtController.value.text);
              },
            ),
          ],
        );
      },
    );
  }
}
