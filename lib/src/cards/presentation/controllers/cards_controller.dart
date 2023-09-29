import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/game_card.dart';
import '../../domain/entities/game_card_form.dart';
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

  void addCard(GameCardForm form) {
    final card = _repository.saveCard(form);
    state = [...state, card];
  }

  void editCard(GameCardForm form) {
    final card = _repository.editCard(form);
    state = [
      ...state.map((e) => card.id == e.id ? card : e),
    ];
  }

  void deleteCard(GameCard card) {
    final deleted = _repository.deleteCard(card);
    state = [
      ...state.where((element) => element.id != deleted.id),
    ];
  }
}
