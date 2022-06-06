/// Support for doing something awesome.
///
/// More dartdocs go here.
library nameof_annotation;

/// Annotation for generate names for code entities
class Nameof {
  /// This setting response for including and excluding elements of class
  final CoverageBehaviour? coverageBehaviour;

  const Nameof({this.coverageBehaviour});
}

///  Annotation for ignore inner elements of class
class NameofIgnore {
  const NameofIgnore();
}

///  Annotation for tagging inner elements of class
class NameofKey {
  /// Set this for override name of element
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
