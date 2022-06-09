import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen_test/annotations.dart';

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [ModelTest] class
abstract class NameofModelTest {
  static const String className = 'ModelTest';

  static const String constructor = '';

  static const String fieldName = 'name';
  static const String fieldId = 'id';

  static const String functionBuildValue = 'buildValue';
}
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
/// Container for names of elements belonging to the [ModelTest2] class
abstract class NameofModelTest2 {
  static const String className = 'ModelTest2';

  static const String constructor = '';

  static const String fieldName = 'name';
  static const String fieldId = 'id';

  static const String propertyGetDescription = 'description';
}
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
/// Container for names of elements belonging to the [MixinTest3] class
abstract class NameofMixinTest3 {
  static const String className = 'MixinTest3';

  static const String fieldYear = '_startUnixEpoch';
}
''')
@Nameof(coverage: Coverage.excludeImplicit)
mixin MixinTest3 {
  final String name = 'Mixin';
  final int id = 0;

  @NameofKey(name: '_startUnixEpoch')
  final year = 1969;
}

@ShouldGenerate(r'''
/// Container for names of elements belonging to the [Cinema] class
abstract class NameofCinema {
  static const String className = 'Cinema';

  static const String constructor = '';

  static const String fieldStreet = 'street';
  static const String fieldValue = 'value';
}
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
