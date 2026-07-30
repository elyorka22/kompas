extension KompasStringX on String {
  String get trimmedOrEmpty => trim();

  bool get isBlank => trim().isEmpty;

  bool get isNotBlank => trim().isNotEmpty;

  String capitalizeFirst() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
