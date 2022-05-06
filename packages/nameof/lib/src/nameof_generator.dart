import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nameof/src/util/element_extensions.dart';
import 'package:nameof/src/util/string_extensions.dart';
import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'model/options.dart';
import 'nameof_visitor.dart';

class NameofGenerator extends GeneratorForAnnotation<Nameof> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS) {
      throw UnsupportedError("This is not a class!");
    }

    /// Получить значение аннотации
    final behaviour = CoverageBehaviour.values.firstWhere((element) =>
        element.toString() ==
        annotation.objectValue.getField('coverageBehaviour')?.toStringValue());

    final options =
        NameofOptions(coverage: behaviour, scope: NameofScope.onlyPublic);

    //annotation.objectValue.getField('coverageBehaviour')?.toStringValue();
    //final behaviorValue = element.getAnnotation(Nameof)?.getField('behaviour')?.toStringValue();

    // По базовым классам можно тоже пройтись визитором

    // final annotatedElements =
    //     (element as ClassElement).fields.where((f) => f.hasAnnotation(Nameof));
    //=============

    final visitor = NameofVisitor(element.name ?? 'NoName');
    element.visitChildren(visitor);
    final code = _generateNames(visitor);

    return code;
  }

  String _generateNames(NameofVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = '_\$Nameof${visitor.className}';

    buffer.writeln('class $classContainerName {');
    buffer.writeln('const $classContainerName();');

    final className = 'final String className = \'${visitor.className}\';';

    final fieldNames = visitor.fields.values
        .map((e) => e.name)
        .map((f) => 'final String field${f.capitalize()} = \'$f\';');

    final functionNames = visitor.functions.values.map((e) => e.name).map(
        (func) =>
            'final String function${func.capitalize().privatize()} = \'$func\';');

    buffer.writeln(className);
    buffer.writeln();
    buffer.writeln(join(fieldNames));
    buffer.writeln();
    buffer.writeln(join(functionNames));

    buffer.writeln('}');

    buffer.writeln('const nameof${visitor.className} = $classContainerName();');

    return buffer.toString();
  }
}
