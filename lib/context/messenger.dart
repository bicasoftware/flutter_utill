import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

mixin Messenger<T extends Widget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void showMessage(
    String message, [
    Duration? duration,
    VoidCallback? onPressed,
    String? actionLabel,
  ]) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? Duration(seconds: 1),
        action: onPressed != null
            ? SnackBarAction(
                label: actionLabel!,
                onPressed: onPressed,
              )
            : null,
      ),
    );
  }
}
