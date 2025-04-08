import 'package:flutter/material.dart';

void kNavigate(BuildContext context, Widget route){
   Navigator.push(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}
