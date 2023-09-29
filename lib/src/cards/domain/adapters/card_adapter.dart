import '../../data/models/card_dto.dart';
import '../entities/game_card.dart';
import '../enum/card_type.dart';

extension GameCardAdapter on CardDto {
  GameCard toEntity(int id) {
    return GameCard(
      id: id,
      contents: contents,
      eval: eval,
      type: CardType.fromCode(type),
    );
  }
}
