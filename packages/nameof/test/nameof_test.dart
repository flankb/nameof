import 'package:test/test.dart';

import 'integration/model_one.dart';

void main() {
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
