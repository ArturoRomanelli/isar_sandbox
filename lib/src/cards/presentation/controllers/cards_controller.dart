import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/game_card.dart';
import '../../domain/repositories/cards_repository_interface.dart';

part 'cards_controller.g.dart';

@riverpod
final class CardsController extends _$CardsController {
  late CardsRepositoryInterface _repository;

  @override
  List<GameCard> build() {
    _repository = ref.watch(cardsRepositoryProvider);
    return _repository.getCards();
  }
}
