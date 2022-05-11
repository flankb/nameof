import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:nameof/src/model/element_info.dart';
import 'package:nameof/src/util/element_extensions.dart';
import 'package:nameof/src/util/string_extensions.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

import 'model/property_info.dart';

class NameofVisitor extends SimpleElementVisitor<void> {
  late String className;

  final constructors = <String, ElementInfo>{};
  final fields = <String, ElementInfo>{};
  final functions = <String, ElementInfo>{};
  final properties = <String, PropertyInfo>{};

  NameofVisitor(this.className);

  @override
  void visitClassElement(ClassElement element) {
    className = element.name;
  }

  @override
  void visitConstructorElement(ConstructorElement element) {
    // className = element.type.returnType.getDisplayString(withNullability: false);
    // return super.visitConstructorElement(element);

    constructors[element.name] = _getElementInfo(element);

    // for (var item in element.parameters) {
    //   constructorParams['${element.name}_${item.name}'] =
    //       _getElementInfo(element, ownerName: element.name);
    // }
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

  // @override
  // void visitFunctionElement(FunctionElement element) {
  //   functions.add(element.name);
  // }

  @override
  void visitMethodElement(MethodElement element) {
    functions[element.name] = _getElementInfo(element);
  }

  ElementInfo _getElementInfo(Element element,
      {@Deprecated("Move to ParameterInfo or Remove") String? ownerName}) {
    if (element.name == null) {
      throw UnsupportedError('Element does not have a name!');
    }

    final isPrivate = element.name!.startsWith('_');
    final isAnnotated = element.hasAnnotation(NameofKey);

    String? name = (isAnnotated
            ? element
                    .getAnnotation(NameofKey)
                    ?.getField('name')
                    ?.toStringValue() ??
                element.name
            : element.name)!
        .cleanize();

    return ElementInfo(
        name: name,
        isPrivate: isPrivate,
        isAnnotated: isAnnotated,
        ownerName: ownerName);
  }
}
