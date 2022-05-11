import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nameof/src/nameof_code_processor.dart';
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

    final behaviour = enumValueForDartObject(
      annotation.read('coverageBehaviour').objectValue,
      CoverageBehaviour.values,
    );

    final options =
        NameofOptions(coverage: behaviour, scope: NameofScope.onlyPublic);

    final visitor = NameofVisitor(element.name ?? 'NoName');
    element.visitChildren(visitor);

    final code = NameofCodeProcessor(options, visitor).process();

    return code;
  }

  T enumValueForDartObject<T>(
    dynamic source,
    List<T> items,
  ) =>
      items[source.getField('index')!.toIntValue()!];
}
