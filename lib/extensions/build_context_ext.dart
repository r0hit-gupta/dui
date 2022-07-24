import 'package:flutter/material.dart';

// extensions on context for media query for width and height
extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
