class ElementInfo {
  @Deprecated("Move to ParameterInfo or Remove")
  final String? ownerName;
  final String name;
  final bool isPrivate;
  final bool isAnnotated;

  ElementInfo(
      {required this.name,
      required this.isPrivate,
      required this.isAnnotated,
      this.ownerName});

  String get scopePrefix => isPrivate ? 'Private' : '';
}
