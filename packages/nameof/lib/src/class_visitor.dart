import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class ClassVisitor extends SimpleElementVisitor<void> {
  late String className;
  final fields = <String>{};
  final functions = <String>{};

  ClassVisitor(this.className);

  @override
  void visitClassElement(ClassElement element) {
    className = element.name;
  }

  // @override
  // visitConstructorElement(ConstructorElement element) {
  //   className = element.type.returnType.getDisplayString(withNullability: false);
  //   return super.visitConstructorElement(element);
  // }

  @override
  void visitFieldElement(FieldElement element) {
    // Getters and Setters included

    fields.add(element.name);
  }

  // @override
  // void visitFunctionElement(FunctionElement element) {
  //   functions.add(element.name);
  // }

  @override
  void visitMethodElement(MethodElement element) {
    functions.add(element.name);
  }
}
