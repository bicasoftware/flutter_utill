import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MultiOptionControll extends StatelessWidget {
  const MultiOptionControll({
    required this.initValue,
    required this.onValueChanged,
    required this.label,
    required this.children,
    required this.selectedColor,
    required this.borderColor,
    Key? key,
  }) : super(key: key);

  final int initValue;
  final void Function(int newVal) onValueChanged;
  final String label;
  final Map<int, Widget> children;
  final Color selectedColor, borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: theme.textTheme.subtitle2,
          ),
        ),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(bottom: 16),
          child: CupertinoSegmentedControl<int>(
            pressedColor: theme.cardColor,
            groupValue: initValue,
            onValueChanged: onValueChanged,
            children: children,
            selectedColor: selectedColor,
            borderColor: borderColor,
            unselectedColor: theme.cardColor,
          ),
        ),
      ],
    );
  }
}
