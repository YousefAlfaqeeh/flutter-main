import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class custom extends StatefulWidget {
  const custom({Key? key}) : super(key: key);

  @override
  State<custom> createState() => _customState();
}

class _customState extends State<custom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [ClipPath(
        clipper: Customshape(),
        child: Container(height: 200,color: Colors.red,))],)),);
  }
}
class Customshape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(25,0);
    var firstStart=Offset(width*.25,height- 50);
    var firstEnd=Offset(width, height-50);

    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secandStart=Offset(width*.75, height-50);
    var secandEnd=Offset(width, height-50);

    path.quadraticBezierTo(secandStart.dx, secandStart.dy, secandEnd.dx, secandEnd.dy);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}