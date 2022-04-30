import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'class_visitor.dart';

class NameofGenerator extends GeneratorForAnnotation<Nameof> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS) {
      throw Exception("This is not a class!");
    }

    final visitor = ClassVisitor();
    element.visitChildren(visitor);

    final code = _generateNames(visitor);

    return code;
  }

  String _generateNames(ClassVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = '_\$Nameof${visitor.className}';

    buffer.writeln('class $classContainerName {');
    buffer.writeln('const $classContainerName();');

    final className = 'final String className = \'${visitor.className}\';';

    final fieldNames =
        visitor.fields.map((f) => 'final String field$f = \'$f\'');

    final functionNames =
        visitor.fields.map((func) => 'final String function$func = \'$func\'');

    buffer.writeln(className);
    buffer.writeln();
    buffer.writeln(fieldNames);
    buffer.writeln();
    buffer.writeln(functionNames);

    buffer.writeln('}');

    buffer.writeln('const nameof${visitor.className} = $classContainerName();');

    return buffer.toString();
  }
}
