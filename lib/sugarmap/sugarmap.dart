import 'package:intl/intl.dart';

extension Sugarmap on Map<String, Object> {
  int asInt(String key) => int.tryParse(this[key]);
  double asDouble(String key) => double.tryParse(this[key]);
  String asString(String key) => this[key] as String;

  bool asBoolFromInt(String key, [int trueValue = 1]) {
    return intToBool(this[key] as int, trueValue);
  }

  int asIntFromBool(String key, [int trueValue = 1, int falseValue = 0]) {
    return boolToInt(this[key] as bool, trueValue, falseValue);
  }

  DateTime asDateTime(String key, [String formatPattern = "yyyy-MM-dd"]) {
    return DateFormat(formatPattern).parse(this[key] as String);
  }
}

int boolToInt(bool v, [int trueValue = 1, int falseValue = 0]) {
  return v ? trueValue : falseValue;
}

bool intToBool(int v, [int trueValue = 1]) {
  return v == trueValue;
}
