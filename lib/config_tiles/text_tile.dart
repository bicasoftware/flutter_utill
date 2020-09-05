import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_utils/config_tiles/error_text.dart';

class TextTile extends FormField<String> {
  TextTile({
    @required Icon icon,
    @required String label,
    @required String hint,
    // @required FormFieldSetter<String> onSaved,
    @required FormFieldSetter<String> onChanged,
    @required FormFieldValidator<String> validator,
    @required String initialValue,
    List<TextInputFormatter> inputFormatters,
    TextInputType inputType = TextInputType.text,
    double trailingWidth = 120,
    bool autoValidate = false,
  }) : super(
          // onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autoValidate,
          builder: (FormFieldState<String> state) {
            return ListTile(
              leading: icon,
              title: Text(label),
              trailing: Container(
                width: trailingWidth,
                child: Container(
                  width: trailingWidth,
                  child: TextFormField(
                    inputFormatters: inputFormatters,
                    keyboardType: inputType,
                    initialValue: initialValue,
                    textAlign: TextAlign.end,
                    onChanged: (s) {
                      state.didChange(s);
                      onChanged(s);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: hint,
                    ),
                  ),
                ),
              ),
              subtitle: state.hasError ? ErrorText(state.errorText) : null,
            );
          },
        );
}
