extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Remove underscore
  String privatize() {
    if (isNotEmpty && this[0] == '_') {
      return substring(1).capitalize(); // TODO Remove capitalize()
    }

    return this;
  }

  /// Clean string representation of element from service symbols
  /// For example '=' symbol in the property setter
  String cleanFromServiceSymbols() {
    return replaceAll('=', '');
  }
}

String join(Iterable<String> codeArray) => codeArray.join('\n');
