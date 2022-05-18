import 'package:test/test.dart';

import 'integration/models.dart';

void main() {
  group('A group of tests for check generation code', () {
    test('test generate code for model one', () {
      expect(nameofModelOne.className, 'ModelOne');
      expect(nameofModelOne.constructor, '');
      expect(nameofModelOne.fieldName, 'name');
      expect(nameofModelOne.fieldId, 'id');
      expect(nameofModelOne.functionBuildValue, 'buildValue');
    });

    test('test generate code for base class', () {
      expect(nameofBaseClass.className, 'BaseClass');
      expect(nameofBaseClass.fieldPrice, 'price');
      expect(nameofBaseClass.constructor, '');
    });

    test('test generate code for mixin', () {
      expect(nameofMixinOne.propertyGetHameleon, 'hameleon');
      expect(nameofMixinOne.className, 'MixinOne');
    });
  });
}
