part of 'ticket_bloc.dart';

@freezed
class TicketEvent with _$TicketEvent {
  const factory TicketEvent.add(Ticket ticket) = _Add;
  const factory TicketEvent.update(Ticket ticket) = _Update;
  const factory TicketEvent.updateTicketWithScannedResult(
    ) = _UpdateTicketWithScannedResult;
}
