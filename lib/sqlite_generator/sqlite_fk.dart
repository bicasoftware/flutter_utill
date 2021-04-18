import 'package:flutter_utils/sqlite_generator/constraint_types.dart';

class SqliteFK {
  SqliteFK({
    required this.referenceTable,
    required this.slaveColumn,
    required this.masterColumn,
    required this.onDelete,
    required this.onUpdate,
  });

  final String referenceTable, slaveColumn, masterColumn;
  final ConstraintTypes onDelete, onUpdate;

  String getConstraint(ConstraintTypes constraint) {
    switch (constraint) {
      case ConstraintTypes.SET_NULL:
        return "SET NULL";
      case ConstraintTypes.SET_DEFAULT:
        return "SET DEFAULT";
      case ConstraintTypes.RESTRICT:
        return "RESTRICT";
      case ConstraintTypes.NO_ACTION:
        return "NO ACTION";
      case ConstraintTypes.CASCADE:
        return "CASCADE";
      default:
        return "CASCADE";
    }
  }

  String generateFK() {
    return """FOREIGN KEY ($slaveColumn) REFERENCES $referenceTable($masterColumn) ON UPDATE ${getConstraint(onUpdate)} ON DELETE ${getConstraint(onDelete)}""";
  }
}
