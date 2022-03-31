import 'package:flutter/material.dart';

Color primaryGreen = const Color(0xff416d6d);
Color secondaryGreen = const Color(0xff16a085);
Color fadedBlack = Colors.black.withAlpha(150);
List<BoxShadow> customShadowBox = [
  BoxShadow(
    color: Colors.grey[300]!,
    blurRadius: 10,
    offset: const Offset(0,10),
  ),
];

List<Map> categories = [
  {"name" : 'All', "iconPath": "images/all.jpg"},
  {"name": "Cats", "iconPath": "images/cat.jpg"},
  {"name": "Dogs", "iconPath": "images/dog.webp"},
  {"name": "Bunnies", "iconPath": "images/bunny.jpg"},
];