import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_shopping_cart,
              size: 70,
              color: Colors.white,
              textDirection: TextDirection.ltr,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Checklist - Compras",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.ltr,
            )
          ],
        ),
      ),
    );
  }
}
