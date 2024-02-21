// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketImpl _$$TicketImplFromJson(Map<String, dynamic> json) => _$TicketImpl(
      id: json['id'] as String,
      quantity: json['quantity'] as String,
      ticketStatus: json['ticketStatus'] as String,
      pricePerTicket: json['pricePerTicket'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$TicketImplToJson(_$TicketImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'ticketStatus': instance.ticketStatus,
      'pricePerTicket': instance.pricePerTicket,
      'createdAt': instance.createdAt,
    };
