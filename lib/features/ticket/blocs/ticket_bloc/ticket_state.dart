part of 'ticket_bloc.dart';

@freezed
class TicketState with _$TicketState {
  const factory TicketState.initial() = _Initial;
  const factory TicketState.loading() = _Loading;
  const factory TicketState.loaded({String ? message,@Default(false) bool isTicketScanning , String? quantity}) = _Loaded;
  const factory TicketState.error(Failure failure) = _Error;
}

