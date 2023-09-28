import 'package:flutter/material.dart';

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
    (card) => Card(
      color: card.color,
      child: Text(
        card.contents,
        style: TextStyle(color: card.color == Colors.black ? Colors.white : Colors.black),
      ),
    ),
  ),
];
