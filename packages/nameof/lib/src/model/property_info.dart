import 'element_info.dart';

class PropertyInfo extends ElementInfo {
  final bool isSetter;
  final bool isGetter;

  PropertyInfo({
    required String name,
    required String originalName,
    required bool isPrivate,
    required bool isAnnotated,
    required bool isIgnore,
    required this.isSetter,
    required this.isGetter,
  })  : assert(isGetter ^ isSetter),
        super(
            name: name,
            originalName: originalName,
            isIgnore: isIgnore,
            isPrivate: isPrivate,
            isAnnotated: isAnnotated);

  factory PropertyInfo.fromElementInfo(ElementInfo based,
      {required bool isGetter, required bool isSetter}) {
    return PropertyInfo(
        name: based.name,
        originalName: based.originalName,
        isIgnore: based.isIgnore,
        isPrivate: based.isPrivate,
        isAnnotated: based.isAnnotated,
        isGetter: isGetter,
        isSetter: isSetter);
  }

  String get propertyPrefix => isSetter ? 'Set' : 'Get';
}
