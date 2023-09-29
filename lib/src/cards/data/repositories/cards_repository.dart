import 'package:isar/isar.dart';

import '../../../shared/domain/errors/unable_to_delete_exception.dart';
import '../../domain/adapters/card_adapter.dart';
import '../../domain/entities/game_card.dart';
import '../../domain/entities/game_card_form.dart';
import '../../domain/repositories/cards_repository_interface.dart';
import '../adapters/form_to_dto_adapter.dart';
import '../models/card_dto.dart';

final class CardsRepository implements CardsRepositoryInterface {
  const CardsRepository(this.db);
  final Isar db;

  @override
  List<GameCard> getCards() {
    throw UnimplementedError('TODO: add repository logic in here');
  }

  @override
  GameCard saveCard(GameCardForm form) => _putCard(form);
  @override
  GameCard editCard(GameCardForm form) => _putCard(form);

  @override
  GameCard deleteCard(GameCard card) {
    final hasBeenDeleted = db.cardDtos.deleteSync(card.id);
    if (!hasBeenDeleted) throw UnableToDeleteException(card);

    return card;
  }

  GameCard _putCard(GameCardForm form) {
    final dto = form.toDto();
    final id = db.cardDtos.putSync(dto);
    return dto.toEntity(id);
  }
}
