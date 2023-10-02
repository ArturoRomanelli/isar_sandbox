class UnrecognizedCardTypeException implements Exception {
  const UnrecognizedCardTypeException(this.number);
  final int number;
  @override
  String toString() => 'Unrecognized card type: $number';
}
