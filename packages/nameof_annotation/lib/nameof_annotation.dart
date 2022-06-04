/// Support for doing something awesome.
///
/// More dartdocs go here.
library nameof_annotation;

/// Annotation for generate names for code entities
class Nameof {
  final CoverageBehaviour coverageBehaviour;

  const Nameof({this.coverageBehaviour = CoverageBehaviour.includeImplicit});
}

///  Annotation for ignore inner elements of class
class NameofIgnore {
  const NameofIgnore();
}

class NameofKey {
  final String? name;

  const NameofKey({this.name});
}

const nameof = Nameof();
const nameofKey = NameofKey();
const nameofIgnore = NameofIgnore();

/// Rule for including inner elements
enum NameofScope {
  /// Include only public members (fields, methods, etc..)
  onlyPublic,

  /// Include public and private elements
  all
}

/// Behaviour for generating nameof code
enum CoverageBehaviour {
  /// Include all elements, even not marked with annotation [NameofKey]
  includeImplicit,

  /// Include elements only tagged with annotation [NameofKey]
  excludeImplicit
}
