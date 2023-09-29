import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../clients/local_client.dart';
import '../../data/repositories/cards_repository.dart';
import '../entities/game_card.dart';
import '../entities/game_card_form.dart';

part 'cards_repository_interface.g.dart';

@riverpod
CardsRepositoryInterface cardsRepository(CardsRepositoryRef ref) {
  final isar = ref.watch(localDbProvider);

  return CardsRepository(isar);
}

abstract interface class CardsRepositoryInterface {
  List<GameCard> getCards();
  GameCard saveCard(GameCardForm form);
  GameCard editCard(GameCardForm form);
  GameCard deleteCard(GameCard card);
}
