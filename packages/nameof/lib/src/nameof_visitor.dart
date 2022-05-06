import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:nameof/src/model/element_info.dart';
import 'package:nameof/src/util/element_extensions.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

class NameofVisitor extends SimpleElementVisitor<void> {
  late String className;

  final constructors = <String, ElementInfo>{};
  final constructorParams = <String, ElementInfo>{};
  final fields = <String, ElementInfo>{};
  final functions = <String, ElementInfo>{};

  NameofVisitor(this.className);

  @override
  void visitClassElement(ClassElement element) {
    className = element.name;
  }

  @override
  visitConstructorElement(ConstructorElement element) {
    // className = element.type.returnType.getDisplayString(withNullability: false);
    // return super.visitConstructorElement(element);
  }

  @override
  void visitFieldElement(FieldElement element) {
    // Getters and Setters included
    fields[element.name] = _getElementInfo(element);
  }

  // @override
  // void visitFunctionElement(FunctionElement element) {
  //   functions.add(element.name);
  // }

  @override
  void visitMethodElement(MethodElement element) {
    functions[element.name] = _getElementInfo(element);
  }

  ElementInfo _getElementInfo(ClassMemberElement element) {
    if (element.name == null) {
      throw UnsupportedError('Element does not have a name!');
    }

    final isPrivate = element.name!.startsWith('_');

    String? name = element.hasAnnotation(NameofKey)
        ? element.getAnnotation(NameofKey)?.getField('name')?.toStringValue() ??
            element.name
        : element.name;

    return ElementInfo(name: name!, isPrivate: isPrivate);
  }
}
