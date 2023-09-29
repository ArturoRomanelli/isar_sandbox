import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/card_type.dart';

part 'game_card_form.freezed.dart';

@unfreezed
class GameCardForm with _$GameCardForm {
  factory GameCardForm({
    @Default('') String description,
    @Default(CardType.white) CardType type,
    @Default(0) double rating,
  }) = _GameCardForm;
}
