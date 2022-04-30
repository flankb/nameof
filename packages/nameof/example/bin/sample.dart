import 'package:nameof_annotation/nameof_annotation.dart';

part 'sample.nameof.dart';

@nameof
class Sample {
  final String name;
  final int id;

  Sample(this.name, this.id);
}
