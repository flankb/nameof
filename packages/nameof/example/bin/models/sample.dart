import 'package:nameof_annotation/nameof_annotation.dart';

part 'sample.nameof.dart';

@nameof
mixin VinilMixin {
  final int vinilColor = 124;
}

@nameof
class BaseClass {
  final double price;

  BaseClass(this.price);
}

@nameof
class Sample extends BaseClass with VinilMixin {
  final String name;

  @nameof
  final int id;

  String get getColor => 'red';

  set setColor(int repr) {}

  Sample(this.name, this.id) : super(0);

  void _calculateAge() {}

  int buildValue() {
    _calculateAge();
    return 0;
  }
}
