import 'package:flutter/material.dart';
import 'package:flutter_utils/config_tiles/base_config_tile.dart';
import 'package:flutter_utils/dictionary.dart';

class TimePickerTile extends StatelessWidget {
  const TimePickerTile({
    Key key,
    this.label,
    this.initialTime,
    this.icon,
    this.onTimeSet,
  }) : super(key: key);

  final String label;
  final TimeOfDay initialTime;
  final Icon icon;
  final Function(TimeOfDay) onTimeSet;

  @override
  Widget build(BuildContext context) {
    return BaseConfigTile(
      trailingWidth: 50,
      label: label,
      icon: icon,
      trailing: Text(
        toShortString(initialTime),
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.end,
      ),
      onTap: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
          cancelText: Dictionary.cancelar,
          confirmText: Dictionary.salvar,
          helpText: label,
        );

        if (newTime != null && newTime != initialTime) {
          onTimeSet(newTime);
        }
      },
    );
  }

  String toShortString(TimeOfDay time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return "$h:$m";
  }
}
