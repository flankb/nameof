import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:nameof/src/model/element_info.dart';
import 'package:nameof/src/util/element_extensions.dart';
import 'package:nameof/src/util/string_extensions.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

import 'model/property_info.dart';

/// Class for collect info about inner elements of class (or mixin)
class NameofVisitor extends SimpleElementVisitor<void> {
  late String className;

  final constructors = <String, ElementInfo>{};
  final fields = <String, ElementInfo>{};
  final functions = <String, ElementInfo>{};
  final properties = <String, PropertyInfo>{};

  NameofVisitor(this.className);

  @override
  void visitConstructorElement(ConstructorElement element) {
    constructors[element.name] = _getElementInfo(element);
  }

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isSynthetic) {
      return;
    }

    fields[element.name] = _getElementInfo(element);
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    if (element.isSynthetic) {
      return;
    }

    properties[element.name] = PropertyInfo.fromElementInfo(
        _getElementInfo(element),
        isGetter: element.isGetter,
        isSetter: element.isSetter);
  }

  @override
  void visitMethodElement(MethodElement element) {
    functions[element.name] = _getElementInfo(element);
  }

  ElementInfo _getElementInfo(Element element) {
    if (element.name == null) {
      throw UnsupportedError('Element does not have a name!');
    }

    final isPrivate = element.name!.startsWith('_');
    final isAnnotated = element.hasAnnotation(NameofKey);
    final isIgnore = element.hasAnnotation(NameofIgnore);

    String? name = (isAnnotated
            ? element
                    .getAnnotation(NameofKey)
                    ?.getField('name')
                    ?.toStringValue() ??
                element.name
            : element.name)!
        .cleanFromServiceSymbols();

    String originalName = element.name!.cleanFromServiceSymbols();

    return ElementInfo(
        name: name,
        originalName: originalName,
        isPrivate: isPrivate,
        isAnnotated: isAnnotated,
        isIgnore: isIgnore);
  }
}
