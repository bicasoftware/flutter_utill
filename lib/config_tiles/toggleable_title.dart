import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_utils/context_helper.dart';

class ToggleableTile extends StatelessWidget {
  const ToggleableTile({
    required this.labels,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  })  : assert(labels.length == isSelected.length),
        super(key: key);

  final List<String> labels;
  final List<bool> isSelected;
  final void Function(int pos) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16),
      child: ToggleButtons(
        children: <Widget>[
          for (int i = 0; i < labels.length; i++)
            Container(
              width: (context.width / labels.length) - 16,
              child: Text(
                labels[i],
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected[i]
                        ? Colors.white
                        : context.theme.primaryColor),
              ),
            )
        ],
        isSelected: isSelected,
        onPressed: onPressed,
        borderColor: context.theme.primaryColor,
        borderRadius: BorderRadius.circular(8),
        selectedColor: context.theme.primaryColor,
        selectedBorderColor: context.theme.primaryColor,
        fillColor: context.theme.primaryColor,
        textStyle: context.textTheme.button
            ?.copyWith(color: context.theme.primaryColor),
      ),
    );
  }
}
