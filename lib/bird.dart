import 'package:flutter/cupertino.dart';

class bird extends StatefulWidget {
  _birdState createState() => _birdState();
}

class _birdState extends State<bird> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("lib/images/birdimage.png"),
      height: 60,
      width: 60,
    );
  }
}
