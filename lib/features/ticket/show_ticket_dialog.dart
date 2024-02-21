
import 'package:flutter/material.dart';
import 'package:ticket_trove/features/ticket/pages/ticket_dialog_page.dart';

Future<void> showTicketDialog(BuildContext context, {required bool isTicketAvailable, String? ticketQuantity})async{
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TicketDialog(
          ticketQuantity: ticketQuantity,
          isTicketAvailable: isTicketAvailable); 
    },
  );

}