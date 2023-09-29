import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/domain/errors/unable_to_delete_exception.dart';
import '../../domain/entities/game_card.dart';
import '../../domain/entities/game_card_form.dart';
import '../../domain/enum/card_mode.dart';
import '../../domain/enum/card_type.dart';
import '../controllers/cards_controller.dart';

class CardDialog extends HookConsumerWidget {
  const CardDialog({
    required this.mode,
    super.key,
    this.card,
  });
  final CardMode mode;
  final GameCard? card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useRef(GlobalKey<FormState>());
    final form = useState(
      GameCardForm(
        description: card?.contents ?? '',
        rating: card?.eval ?? 0,
        type: card?.type ?? CardType.white,
      ),
    );

    String? validation(String? value) {
      if (value == null || value.isEmpty) return 'Campo obbligatorio';
      return null;
    }

    void deleteCard() {
      try {
        ref.read(cardsControllerProvider.notifier).deleteCard(card!);
        context.pop();
      } on UnableToDeleteException {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Operazione in errore')),
        );
      }
    }

    void saveCard() {
      switch (mode) {
        case CardMode.newCard:
          ref.read(cardsControllerProvider.notifier).addCard(form.value);
        case CardMode.editCard:
          ref.read(cardsControllerProvider.notifier).editCard(form.value);
      }

      context.pop();
    }

    return Dialog.fullscreen(
      child: Form(
        key: formKey.value,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onChanged: (value) => form.value.description = value,
                validator: (value) => validation(value?.trim()),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(label: Text('Description')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Rating: '),
                  RatingBar.builder(
                    itemSize: 24,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    initialRating: form.value.rating,
                    allowHalfRating: true,
                    onRatingUpdate: (value) => form.value.rating = value,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<CardType>(
                  title: const Text('White'),
                  value: CardType.white,
                  groupValue: form.value.type,
                  onChanged: (value) => form.value.type = value!,
                ),
                RadioListTile<CardType>(
                  title: const Text('Black'),
                  value: CardType.black,
                  groupValue: form.value.type,
                  onChanged: (value) => form.value.type = value!,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: saveCard,
                child: switch (mode) {
                  CardMode.newCard => const Text('Conferma'),
                  CardMode.editCard => const Text('Modifica'),
                },
              ),
            ),
            if (mode case CardMode.editCard)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: deleteCard,
                  child: const Text('Elimina'),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                ),
                onPressed: context.pop,
                child: const Text('Annulla'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
