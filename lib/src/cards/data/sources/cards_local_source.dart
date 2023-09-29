import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../clients/local_client.dart';
import '../../domain/entities/game_card.dart';

part 'cards_local_source.g.dart';

@riverpod
CardsLocalSource cardsLocalSource(CardsLocalSourceRef ref) {
  final isar = ref.watch(localDbProvider);
  return CardsLocalSource(isar);
}

final class CardsLocalSource {
  const CardsLocalSource(this.localClient);
  final Isar localClient;

  List<GameCard> getcards() {
    throw UnimplementedError('TODO: use `localClient` to fetch data');
  }
}
