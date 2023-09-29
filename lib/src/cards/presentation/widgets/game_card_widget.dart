import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/game_card.dart';
import '../../domain/enum/card_mode.dart';
import 'card_dialog.dart';

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
      color: card.type.color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (_) => CardDialog(
                mode: CardMode.editCard,
                card: card,
              ),
            );
          },
          child: Column(
            children: [
              Text(
                card.contents,
                style: TextStyle(color: card.type.next.color),
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
      ),
    );
  }
}
