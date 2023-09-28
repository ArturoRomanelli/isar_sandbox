import 'package:flutter/material.dart';

import '../../data/models/card_dto.dart';
import '../../data/models/card_type_dto.dart';
import '../entities/game_card.dart';

extension GameCardAdapter on CardDto {
  GameCard toEntity() {
    return GameCard(
      contents: contents,
      eval: eval,
      color: switch (type) {
        CardTypeDto.black => Colors.black,
        CardTypeDto.white => Colors.white,
      },
    );
  }
}
