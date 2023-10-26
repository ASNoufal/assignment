import 'package:freezed_annotation/freezed_annotation.dart';
part 'field.freezed.dart';

@freezed
class field with _$field {
  const factory field({
    required String value,
    @Default('') String errormessage,
    @Default(false) bool isValid,
  }) = _field;
}
