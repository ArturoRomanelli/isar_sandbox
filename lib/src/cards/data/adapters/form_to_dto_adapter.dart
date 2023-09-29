import '../../domain/entities/game_card_form.dart';
import '../models/card_dto.dart';

extension FormToDtoAdapter on GameCardForm {
  CardDto toDto() {
    return CardDto(
      contents: description!,
      eval: rating!,
      type: type!.code,
    );
  }
}
