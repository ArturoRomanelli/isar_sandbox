import 'package:flutter/material.dart';

import '../errors/unrecognized_card_type_exception.dart';

enum CardType {
  black(0),
  white(1);

  const CardType(this.code);
  factory CardType.fromCode(int code) {
    return switch (code) {
      0 => CardType.black,
      1 => CardType.white,
      _ => throw UnrecognizedCardTypeException(code),
    };
  }
  final int code;

  Color get color => switch (this) {
        black => Colors.black,
        white => Colors.white,
      };

  CardType get next {
    final nextIndex = (index + 1) % CardType.values.length;
    return CardType.values[nextIndex];
  }
}
