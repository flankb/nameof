import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'class_visitor.dart';

extension StringExtension on String {
  String capitalize() {
    if (this == '') return '';

    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String privatize() {
    if (this == '') return '';

    if (this[0] == '_') {
      return "Private${substring(1).capitalize()}";
    }

    return this;
  }
}

class NameofGenerator extends GeneratorForAnnotation<Nameof> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS) {
      throw Exception("This is not a class!");
    }

    final visitor = ClassVisitor(element.name ?? 'NoName');
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

    final fieldNames = visitor.fields
        .map((f) => 'final String field${f.capitalize()} = \'$f\';');

    final functionNames = visitor.functions.map((func) =>
        'final String function${func.capitalize().privatize()} = \'$func\';');

    buffer.writeln(className);
    buffer.writeln();
    buffer.writeln(_join(fieldNames));
    buffer.writeln();
    buffer.writeln(_join(functionNames));

    buffer.writeln('}');

    buffer.writeln('const nameof${visitor.className} = $classContainerName();');

    return buffer.toString();
  }

  String _join(Iterable<String> codeArray) => codeArray.join('\n');
}
