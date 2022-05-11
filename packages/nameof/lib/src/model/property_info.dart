import 'element_info.dart';

class PropertyInfo extends ElementInfo {
  final bool isSetter;
  final bool isGetter;

  PropertyInfo({
    required String name,
    required bool isPrivate,
    required bool isAnnotated,
    required this.isSetter,
    required this.isGetter,
  })  : assert(isGetter ^ isSetter),
        super(name: name, isPrivate: isPrivate, isAnnotated: isAnnotated);

  factory PropertyInfo.fromElementInfo(ElementInfo based,
      {required bool isGetter, required bool isSetter}) {
    return PropertyInfo(
        name: based.name,
        isPrivate: based.isPrivate,
        isAnnotated: based.isAnnotated,
        isGetter: isGetter,
        isSetter: isSetter);
  }

  String get propertyPrefix => isSetter ? 'Set' : 'Get';
}
