import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<T> showRoundedBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double radius = 8,
}) async {
  return await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    ),
    builder: (_) => child,
  );
}
