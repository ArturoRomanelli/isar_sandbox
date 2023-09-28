import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/cards_repository.dart';
import '../../data/sources/cards_local_source.dart';
import '../entities/game_card.dart';

part 'cards_repository_interface.g.dart';

@riverpod
CardsRepositoryInterface cardsRepository(CardsRepositoryRef ref) {
  final local = ref.watch(cardsLocalSourceProvider);

  return CardsRepository(local);
}

abstract interface class CardsRepositoryInterface {
  GameCard getCards();
}
