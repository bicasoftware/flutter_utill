import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/config_tiles/error_text.dart';

class TimeTile extends FormField<TimeOfDay> {
  TimeTile({
    @required TimeOfDay initialTime,
    @required FormFieldSetter<TimeOfDay> onSaved,
    FormFieldSetter<TimeOfDay> onChanged,
    String horaLabel: "Hora",
    String minuteLabel: "Minutos",
    String errorMessage: "Os valores de minuto e hora devem ser adicionados",
  }) : super(
          validator: (TimeOfDay t) {
            if (t.hour != null && t.minute != null) {
              if (!(t.hour >= 0 && t.hour < 24)) {
                return "Hora inválida";
              } else if (!(t.minute >= 0 && t.minute < 60)) {
                return 'Minutos inválidos';
              } else {
                return null;
              }
            } else {
              return "Os valores de minuto e hora devem ser adicionados";
            }
          },
          onSaved: onSaved,
          initialValue: initialTime,
          builder: (FormFieldState<TimeOfDay> state) {
            return Container(
              width: double.maxFinite,
              height: 80,
              color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          _TimeTextBox(
                            hint: "18",
                            maxValue: 23,
                            value: state.value.hour,
                            onChange: (String s) {
                              final newTime =
                                  TimeOfDay(hour: int.tryParse(s), minute: state.value.minute);
                              state.didChange(newTime);
                              onChanged(newTime);
                            },
                          ),
                          _TimeTileText(minuteLabel),
                        ],
                      ),
                      /* Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _TimeTileText(horaLabel),
                          _TimeTextBox(
                            hint: "18",
                            maxValue: 23,
                            value: state.value.hour,
                            onChange: (String s) {
                              final newTime =
                                  TimeOfDay(hour: int.tryParse(s), minute: state.value.minute);
                              state.didChange(newTime);
                              onChanged(newTime);
                            },
                          ),
                        ],
                      ), */

                      /* Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _TimeTileText(minuteLabel),
                          _TimeTextBox(
                            hint: "00",
                            maxValue: 59,
                            value: state.value.minute,
                            onChange: (s) {
                              final newTime =
                                  TimeOfDay(hour: state.value.hour, minute: int.tryParse(s));
                              state.didChange(newTime);
                              onChanged(newTime);
                            },
                          ),
                        ],
                      ), */
                    ],
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ErrorText(
                      state.hasError ? state.errorText : "",
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            );
          },
        );
}

class _TimeTextBox extends StatelessWidget {
  const _TimeTextBox({
    @required this.hint,
    @required this.maxValue,
    @required this.value,
    @required this.onChange,
    Key key,
  }) : super(key: key);

  final String hint;
  final int maxValue;
  final int value;
  final void Function(String s) onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value.toString().padLeft(2, "0"),
      style: TextStyle(
        fontSize: 25,
      ),
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        counterText: "",
        fillColor: Colors.grey[100],
        filled: true,
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: 2,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: onChange,
    );
  }
}

class _TimeTileText extends StatelessWidget {
  _TimeTileText(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(label, style: theme.textTheme.overline);
  }
}
