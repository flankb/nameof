extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';

    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String privatize() {
    // TODO При переопределении имени на начинающееся с '_'
    // работает неверно (подставляет префикс Private если элемент публичный)
    if (isNotEmpty && this[0] == '_') {
      return "Private${substring(1).capitalize()}";
    }

    return this;
  }

  String cleanize() {
    return replaceAll('=', '');
  }
}

String join(Iterable<String> codeArray) => codeArray.join('\n');
