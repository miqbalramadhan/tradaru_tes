import 'dart:ui';
import 'package:flutter/material.dart';
const bgColor = Color(0xFFf7f7f7);
const primaryColor = Color(0xFF4e54ae);
const secondColor = Color(0xFFa0daf3);
const redColor = Color(0xFFf5565d);
const yellowColor = Color(0xFFfdd445);
const pinkColor = Color(0xFFf9a1da);
const blueColor = Color(0xFF6ea2ff);
const blackColor = Color(0xFF0f1223);
const greyColor = Color(0xFFb7b9c8);
final ColorPrimaryLight = Colors.deepOrangeAccent;

Widget VisibleText() {
  return Visibility(
    child: Container(
      margin: EdgeInsets.only(top: 10, left: 0),
      child: Text(""),
    ),
    visible: false,
  );
}
