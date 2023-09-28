import '../../domain/entities/game_card.dart';
import '../../domain/repositories/cards_repository_interface.dart';
import '../sources/cards_local_source.dart';

final class CardsRepository implements CardsRepositoryInterface {
  const CardsRepository(
    this.local,
  );

  final CardsLocalSource local;

  @override
  GameCard getCards() {
    throw UnimplementedError('TODO: add repository logic in here');
  }
}
