import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_card.freezed.dart';

@freezed
class GameCard with _$GameCard {
  const factory GameCard({
    required String contents,
    required double eval,
    required Color color,
  }) = _GameCard;
}
