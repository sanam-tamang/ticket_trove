import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ticket_total_price_state.dart';



class TicketTotalPriceCubit extends Cubit<TicketTotalPriceState> {
  TicketTotalPriceCubit() : super(const TicketTotalPriceState());

  void changeTicketPriceAndQuantity({required int quantity, required double ticketPrice}) {
    double totalTicketPrice = ticketPrice* quantity;
    emit(TicketTotalPriceState(totalPrice: totalTicketPrice, quantity: quantity, pertTicketPrice: ticketPrice));
  }
}
