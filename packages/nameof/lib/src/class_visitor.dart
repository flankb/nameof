import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class ClassVisitor extends SimpleElementVisitor<void> {
  late String className;
  final fields = <String>{};
  final functions = <String>{};

  ClassVisitor(this.className);

  // @override
  // void visitClassElement(ClassElement element) {
  //   className = element.name;
  // }

  @override
  void visitFieldElement(FieldElement element) {
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
