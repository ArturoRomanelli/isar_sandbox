import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/enum/card_mode.dart';
import '../controllers/cards_controller.dart';
import '../widgets/card_dialog.dart';
import '../widgets/game_card_widget.dart';

class CardsPage extends HookConsumerWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardList = ref.watch(cardsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards Against Humanity'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          for (final card in cardList) GameCardWidget(card: card),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (_) => const CardDialog(mode: CardMode.newCard),
          );
        },
      ),
    );
  }
}
