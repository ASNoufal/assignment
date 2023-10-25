import 'package:freezed_annotation/freezed_annotation.dart';
part 'authfailures.freezed.dart';

@freezed
class Authfailures with _$Authfailures {
  const factory Authfailures.emailandpasswordwrong(String error) =
      emailandpasswordwrong;
  const factory Authfailures.clienterror(String error) = Clienterror;
  const factory Authfailures.servererror(String error) = Servererror;
  const factory Authfailures.emailalreadyinuse(String error) =
      Emailalreadyinuse;
}
