import 'package:flutter_utils/sqlite_generator/sqlite_column.dart';
import 'package:flutter_utils/sqlite_generator/sqlite_fk.dart';

class SqliteTable {
  SqliteTable(
    this.tableName, {
    required this.columns,
    this.fk,
  })  : assert(columns.isNotEmpty),
        assert(tableName.isNotEmpty);

  String tableName;
  Map<String, SqliteColumn> columns;
  final SqliteFK? fk;

  String makeCreateQuery() {
    String sql = "CREATE TABLE IF NOT EXISTS $tableName(";
    final rows = <String>[];
    columns.forEach((k, v) => rows.add("$k ${v.build()}"));
    sql += rows.join(',');
    if (fk != null) {
      sql += ", ";
      sql += fk?.generateFK() ?? "";
    }

    return sql += ');';
  }
}
