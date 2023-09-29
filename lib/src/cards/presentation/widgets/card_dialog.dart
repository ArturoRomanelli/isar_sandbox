import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../clients/local_client.dart';
import '../../data/models/card_dto.dart';
import '../../data/models/card_type_dto.dart';
import '../../domain/enum/card_mode.dart';

enum Colours { white, black }

class CardDialog extends HookConsumerWidget {
  const CardDialog({
    required this.mode,
    super.key,
    this.description,
    this.eval,
    this.color,
  });

  final CardMode mode;
  final String? description;
  final double? eval;
  final Colours? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(localDbProvider);
    final textController = useTextEditingController();
    final formKey = useRef(GlobalKey<FormState>());
    final rating = useState<double>(0);
    final colours = useState<Colours>(Colours.white);

    if (mode == CardMode.editCard) {
      textController.text = description!;
      rating.value = eval!;
      colours.value = color!;
    }

    String? _validation(String? value) {
      if (value == null || value.isEmpty) return 'Campo obbligatorio';
      return null;
    }

    Future<void> saveCard({
      required String contents,
      required double eval,
      required Colours color,
    }) async {
      final newCard = CardDto(
        contents: contents,
        eval: eval,
        type: switch (color) {
          Colours.white => CardTypeDto.white,
          Colours.black => CardTypeDto.black
        },
      );
      await isar.writeTxn(() async {
        await isar.cardDtos.put(newCard);
      });
    }

    return Dialog.fullscreen(
      child: Form(
        key: formKey.value,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                validator: (value) => _validation(value?.trim()),
                controller: textController,
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
                    initialRating: rating.value,
                    allowHalfRating: true,
                    onRatingUpdate: (value) {
                      rating.value = value;
                    },
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<Colours>(
                  title: const Text('White'),
                  value: Colours.white,
                  groupValue: colours.value,
                  onChanged: (value) => colours.value = value!,
                ),
                RadioListTile<Colours>(
                  title: const Text('Black'),
                  value: Colours.black,
                  groupValue: colours.value,
                  onChanged: (value) => colours.value = value!,
                ),
              ],
            ),
            if (mode == CardMode.newCard)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    saveCard(
                      contents: textController.text,
                      eval: rating.value,
                      color: colours.value,
                    );
                    context.pop();
                  },
                  child: const Text('Conferma'),
                ),
              ),
            if (mode == CardMode.editCard)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Modifica'),
                ),
              ),
            if (mode == CardMode.editCard)
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Elimina'),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
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
