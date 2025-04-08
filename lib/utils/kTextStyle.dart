import 'package:flutter/material.dart';

TextStyle? kTextStyle(
    {double? size = 20,
    isBold = FontWeight.normal,
    Color color = Colors.black}) {
  return TextStyle(
    color: color,
    fontWeight: isBold,
    fontSize: size,
  );
}
