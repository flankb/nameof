extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';

    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String privatize() {
    if (isNotEmpty && this[0] == '_') {
      return "Private${substring(1).capitalize()}";
    }

    return this;
  }
}

String join(Iterable<String> codeArray) => codeArray.join('\n');
