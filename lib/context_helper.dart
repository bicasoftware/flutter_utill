import 'package:flutter/material.dart';

extension ContextHelper on BuildContext {

  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme {
    return theme.textTheme;
  }

  bool get isDarkMode {
    return theme.brightness == Brightness.dark;
  }

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}
