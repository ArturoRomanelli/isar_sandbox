import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/card_type.dart';

part 'game_card.freezed.dart';

@freezed
class GameCard with _$GameCard {
  const factory GameCard({
    required int id,
    required String contents,
    required double eval,
    required CardType type,
  }) = _GameCard;
}
