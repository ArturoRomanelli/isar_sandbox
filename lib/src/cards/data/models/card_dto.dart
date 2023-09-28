import 'package:isar/isar.dart';

import 'card_type_dto.dart';

part 'card_dto.g.dart';

@collection
class CardDto {
  const CardDto({
    required this.contents,
    required this.eval,
    required this.type,
    this.id = Isar.autoIncrement,
  });

  final Id id;
  final String contents;
  final double eval;
  @enumerated
  final CardTypeDto type;
}
