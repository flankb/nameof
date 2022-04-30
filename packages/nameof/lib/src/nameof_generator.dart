import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen/source_gen.dart';

class NameofGenerator extends GeneratorForAnnotation<Nameof> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    // TODO: implement generateForAnnotatedElement
    throw UnimplementedError();
  }
}
