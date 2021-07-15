import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class barrier extends StatelessWidget {
  double height;

  barrier({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: height,
      decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(width: 8,color: Colors.white),
      borderRadius: BorderRadius.circular(15)),
    );
  }
}
