import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../clients/local_client.dart';
import '../../data/models/card_dto.dart';
import '../../domain/adapters/card_adapter.dart';
import '../widgets/game_card_widget.dart';
import '../widgets/new_card_dialog.dart';

class CardsPage extends HookConsumerWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(localDbProvider);

    final cardList = isar.cardDtos.where().findAllSync();

    final cardWidgets = [
      ...cardList.map((dto) => dto.toEntity()).map(
            (card) => GameCardWidget(
              card: card,
            ),
          ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards Against Humanity'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: cardWidgets,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(context: context, builder: (_) => const NewCardDialog());
        },
      ),
    );
  }
}
