import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderPath extends StatelessWidget {
  final Color colors1;
  final Color colors2;

  const HeaderPath({
    Key key,
    this.colors1,
    this.colors2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BezierClipper(),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              colors1, //Colors.blue[200],
              colors2, //Colors.blue,
            ],
          ),
          color: colors2, //Colors.blue,
        ),
      ),
    );
  }
}

class _BezierClipper extends CustomClipper<Path> {
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
