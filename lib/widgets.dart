import 'package:flutter/material.dart';

/// Colors
Color blueColor = Colors.blue;
Color orangeColor = Colors.orange;

/// Text
Widget wText(text, color, fontSize, fontWeight) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

/// SizeBox
Widget wSizedBoxHeight(height) {
  return SizedBox(
    height: height,
  );
}

Future wPush(context, page) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ));
}
