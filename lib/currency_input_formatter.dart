import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({
    this.maxDigits = 2,
  });
  final int maxDigits;

  static String formatValue(double valor) {
    final f = NumberFormat("#,##0.00", "pt_BR");
    return "R\$ ${f.format(valor / 100)}";
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    final valor = double.parse(newValue.text);
    final newText = formatValue(valor);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
