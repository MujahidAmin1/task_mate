import 'package:flutter/material.dart';

TextStyle? kTextStyle(
    {double? size = 20,
    isBold = false,
    Color color = Colors.black}) {
  return TextStyle(
    color: color,
    fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
    fontSize: size,
  );
}
