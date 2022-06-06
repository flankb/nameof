import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:nameof/src/nameof_code_processor.dart';
import 'package:nameof/src/util/enum_extensions.dart';
import 'package:nameof_annotation/nameof_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:collection/collection.dart';
import 'model/options.dart';
import 'nameof_visitor.dart';

class NameofGenerator extends GeneratorForAnnotation<Nameof> {
  final Map<String, dynamic> config;

  NameofGenerator(this.config);

  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element.kind != ElementKind.CLASS) {
      throw UnsupportedError("This is not a class!");
    }

    final options = _parseConfig(annotation);

    final visitor = NameofVisitor(element.name ??
        () {
          throw UnsupportedError(
              'Class or mixin element does not have a name!');
        }());
    element.visitChildren(visitor);

    final code = NameofCodeProcessor(options, visitor).process();

    return code;
  }

  NameofOptions _parseConfig(ConstantReader annotation) {
    final coverageConfigString = config['coverage']?.toString();

    final coverageConfig = Coverage.values
        .firstWhereOrNull((cb) => coverageConfigString == cb.toShortString());

    final coverageAnnotation = enumValueForDartObject(
      annotation.read('coverage'),
      Coverage.values,
    );

    return NameofOptions(
        coverage:
            coverageAnnotation ?? coverageConfig ?? Coverage.includeImplicit,
        scope: NameofScope.onlyPublic);
  }

  T? enumValueForDartObject<T>(
    ConstantReader reader,
    List<T> items,
  ) {
    return reader.isNull
        ? null
        : items[reader.objectValue.getField('index')!.toIntValue()!];
  }
}
