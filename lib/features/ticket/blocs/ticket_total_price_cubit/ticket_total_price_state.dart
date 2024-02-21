// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ticket_total_price_cubit.dart';

class TicketTotalPriceState extends Equatable {
  const TicketTotalPriceState({
    this.totalPrice = 0.0,
    this.quantity = 0,
     this.pertTicketPrice = 0.0,
  });
  final double totalPrice;
  final int quantity;
  final double pertTicketPrice;

  @override
  List<Object> get props => [totalPrice, quantity];
}
