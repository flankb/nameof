import 'package:nameof_annotation/nameof_annotation.dart';

part 'model_one.nameof.dart';

@nameof
class ModelOne {
  final String name;
  final int id;

  ModelOne(this.name, this.id);

  void _calculateAge() {}

  int buildValue() {
    _calculateAge();
    return 0;
  }
}
