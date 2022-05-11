import 'package:nameof/src/util/string_extensions.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

import 'model/element_info.dart';
import 'model/options.dart';
import 'model/property_info.dart';
import 'nameof_visitor.dart';

class NameofCodeProcessor {
  final NameofOptions options;
  final NameofVisitor visitor;

  NameofCodeProcessor(this.options, this.visitor);

  String _generateNames(NameofVisitor visitor) {
    StringBuffer buffer = StringBuffer();

    final classContainerName = '_\$Nameof${visitor.className}';

    buffer.writeln('class $classContainerName {');
    buffer.writeln('const $classContainerName();');

    final className = 'final String className = \'${visitor.className}\';';

    final constructorNames = getFilteredNames(visitor.constructors.values)
        .map((e) => e.name)
        .map((f) =>
            'final String constructor${f.capitalize().privatize()} = \'$f\';');

    final fieldNames = getFilteredNames(visitor.fields.values)
        .map((e) => e.name)
        .map(
            (f) => 'final String field${f.capitalize().privatize()} = \'$f\';');

    final functionNames = getFilteredNames(visitor.functions.values)
        .map((e) => e.name)
        .map((func) =>
            'final String function${func.capitalize().privatize()} = \'$func\';');

    final propertyNames = getFilteredNames(visitor.properties.values).map((prop) =>
        'final String property${(prop as PropertyInfo).propertyPrefix}${prop.name.capitalize().privatize()} = \'${prop.name}\';');

    buffer.writeln(className);

    buffer.writeln();
    buffer.writeln(join(constructorNames));

    buffer.writeln();
    buffer.writeln(join(fieldNames));

    buffer.writeln();
    buffer.writeln(join(propertyNames));

    buffer.writeln();
    buffer.writeln(join(functionNames));

    buffer.writeln('}');

    buffer.writeln('const nameof${visitor.className} = $classContainerName();');

    return buffer.toString();
  }

  Iterable<ElementInfo> getFilteredNames(Iterable<ElementInfo> infos) {
    return options.coverage == CoverageBehaviour.includeImplicit
        ? infos.map((e) => e)
        : infos.where((element) => element.isAnnotated).map((e) => e);
  }

  String process() {
    return _generateNames(visitor);
  }
}
