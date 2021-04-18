import 'package:flutter_utils/sqlite_generator/column_types.dart';

mixin SqliteColumnHelper {
  String build();

  String isNullable(bool val) {
    return !val ? "NOT NULL" : "";
  }

  Object _secureEscape(Object value) {
    if (value is String) {
      return """ '$value' """;
    }
    return value;
  }

  String hasDefault(Object? defaultValue) {
    return defaultValue != null ? "DEFAULT ${_secureEscape(defaultValue)}" : "";
  }

  String getColumnType(ColumnTypes type) {
    switch (type) {
      case ColumnTypes.PRIMARY_KEY:
        return "INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT";
      case ColumnTypes.INTEGER:
        return "INTEGER";
      case ColumnTypes.REAL:
        return "REAL";
      case ColumnTypes.TEXT:
        return "TEXT";
      default:
        return "TEXT";
    }
  }
}
