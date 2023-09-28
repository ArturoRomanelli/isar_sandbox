import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/game_card.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards Against Humanity'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: cardWidgets,
      ),
    );
  }
}

final cardList = [
  const GameCard(
    contents: "Generally, having no idea what's going on.",
    eval: 5,
    color: Colors.white,
  ),
  const GameCard(
    contents: 'You are not alone. Millions of Americans struggle with _______ every day.',
    eval: 3,
    color: Colors.black,
  ),
];

final cardWidgets = [
  ...cardList.map(
    (card) => GameCardWidget(
      card: card,
    ),
  ),
];

class GameCardWidget extends HookWidget {
  const GameCardWidget({
    required this.card,
    super.key,
  });

  final GameCard card;

  @override
  Widget build(BuildContext context) {
    final rating = useState<double>(0);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: card.color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Text(
                card.contents,
                style: TextStyle(color: card.color == Colors.black ? Colors.white : Colors.black),
              ),
            ),
            const Spacer(),
            RatingBar.builder(
              itemSize: 24,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              allowHalfRating: true,
              initialRating: card.eval,
              onRatingUpdate: (value) {
                rating.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
