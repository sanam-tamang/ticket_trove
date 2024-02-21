import 'package:freezed_annotation/freezed_annotation.dart';
part 'ticket.freezed.dart';
part 'ticket.g.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket(
      { required  String id,
      required String quantity,
      required String ticketStatus,
      required String pricePerTicket,
      required  String createdAt,
      }) = _Ticket;
     factory Ticket.fromJson(Map<String,dynamic> json) => _$TicketFromJson(json);
}
