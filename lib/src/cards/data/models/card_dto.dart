import 'package:isar/isar.dart';

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
  final int type;
}
