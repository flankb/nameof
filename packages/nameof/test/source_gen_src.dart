import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
class _$NameofModelTest {
  const _$NameofModelTest();
  final String className = 'ModelTest';

  final String constructor = '';

  final String fieldName = 'name';
  final String fieldId = 'id';

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

@ShouldGenerate(r'''
class _$NameofModelTest2 {
  const _$NameofModelTest2();
  final String className = 'ModelTest2';

  final String constructor = '';

  final String fieldName = 'name';
  final String fieldId = 'id';

  final String propertyGetDescription = 'description';
}

const nameofModelTest2 = _$NameofModelTest2();
''')
@nameof
class ModelTest2 {
  final String name;
  final int id;

  @NameofKey()
  String get description => 'Description';

  ModelTest2(this.name, this.id);
}

@ShouldGenerate(r'''
class _$NameofMixinTest3 {
  const _$NameofMixinTest3();
  final String className = 'MixinTest3';

  final String fieldStartUnixEpoch = '_startUnixEpoch';
}

const nameofMixinTest3 = _$NameofMixinTest3();
''')
@Nameof(coverageBehaviour: CoverageBehaviour.excludeImplicit)
mixin MixinTest3 {
  final String name = 'Mixin';
  final int id = 0;

  @NameofKey(name: '_startUnixEpoch')
  final year = 1969;
}

@ShouldGenerate(r'''
class _$NameofCinema {
  const _$NameofCinema();
  final String className = 'Cinema';

  final String constructor = '';

  final String fieldStreet = 'street';
  final String fieldValue = 'value';
}

const nameofCinema = _$NameofCinema();
''')
@nameof
class Cinema {
  String street;
  int value;

  @nameofIgnore
  int rooms;

  Cinema({
    required this.street,
    required this.value,
    required this.rooms,
  });
}
