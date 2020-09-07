import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils/sugarmap/sugarmap.dart';

void main() {
  test('sugar test', () {
    final Map<String, Object> map = {
      "ativo": 1,
      "ativoBool": false,
      "data": "2020-04-15",
    };

    assert(map.asBoolFromInt("ativo"));
    assert(map.asIntFromBool("ativoBool") == 0);
    assert(map.asIntFromBool("ativoBool", 99, 12) == 12);
    assert(map.asDateTime('data') is DateTime);
    assert(map.asDateTime('data').year == 2020);
    assert(map.asDateTime('data').month == 4);
    assert(map.asDateTime('data').day == 15);
  });
}
