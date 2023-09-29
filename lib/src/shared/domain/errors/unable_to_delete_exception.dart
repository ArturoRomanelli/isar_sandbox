class UnableToDeleteException implements Exception {
  const UnableToDeleteException(this.element);
  final Object? element;
  @override
  String toString() {
    return 'Unable to delete this element: $element';
  }
}
