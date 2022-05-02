import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
class _$NameofModelTest {
  const _$NameofModelTest();
  final String className = 'ModelTest';

  final String fieldName = 'name';
  final String fieldId = 'id';

  final String functionPrivateCalculateAge = '_calculateAge';
  final String functionBuildValue = 'buildValue';
}

const nameofModelTest = _$NameofModelTest();
''')
@nameof
class ModelTest {
  final String name;
  final int id;

  ModelTest(this.name, this.id);

  void _calculateAge() {}

  int buildValue() {
    _calculateAge();
    return 0;
  }
}
