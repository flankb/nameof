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

@Nameof(coverageBehaviour: CoverageBehaviour.excludeImplicit)
class Sample extends BaseClass with VinilMixin {
  final String name;
  String _behind = '';

  int length;

  factory Sample.mega() {
    return Sample('MEGA', 342, 12);
  }

  final int id;

  @NameofKey(name: '_abracadabra')
  String get getColor => 'red';

  set setColor(int repr) {}

  String get behind => _behind;

  set behind(String val) {
    _behind = val;
  }

  Sample(this.name, this.id, this.length) : super(0);

  void _calculateAge() {}

  int buildValue() {
    _calculateAge();
    return 0;
  }
}
