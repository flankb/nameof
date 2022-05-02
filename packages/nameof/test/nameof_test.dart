import 'package:test/test.dart';

import 'integration/model_one.dart';

void main() {
  // TODO Использовать source_gen_test
  // Можно дополнить его тестом build_test
  group('A group of tests for check generation code', () {
    test('test generate code', () {
      expect(nameofModelOne.className, 'ModelOne');
      expect(nameofModelOne.fieldName, 'name');
      expect(nameofModelOne.fieldId, 'id');
      expect(nameofModelOne.functionPrivateCalculateAge, '_calculateAge');
      expect(nameofModelOne.functionBuildValue, 'buildValue');
    });
  });
}
