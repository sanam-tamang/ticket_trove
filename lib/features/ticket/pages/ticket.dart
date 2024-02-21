import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ticket_trove/common/blocs/user_bloc/user_bloc.dart';
import 'package:ticket_trove/common/utils/custom_printer.dart';
import 'package:ticket_trove/common/utils/string_parser.dart';
import 'package:ticket_trove/common/widgets/custom_text_field.dart';
import 'package:ticket_trove/dependency_injection.dart';
import 'package:ticket_trove/features/ticket/blocs/ticket_bloc/ticket_bloc.dart';
import 'package:ticket_trove/features/ticket/blocs/ticket_total_price_cubit/ticket_total_price_cubit.dart';
import 'package:ticket_trove/features/ticket/models/ticket.dart';
import 'package:uuid/uuid.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late TextEditingController _ticketQuantity;
  late TextEditingController _ticketPriceController;
  late TicketTotalPriceCubit _totalPriceCubit;
  static const int initialTicketQuantity = 1;
  final _initialTicketPrice = 10.0;

  @override
  void initState() {
    // _nameController = TextEditingController();
    _ticketPriceController =
        TextEditingController(text: _initialTicketPrice.toString());
    _ticketQuantity =
        TextEditingController(text: initialTicketQuantity.toString());
    _totalPriceCubit = sl<TicketTotalPriceCubit>();
    _totalPriceCubit.changeTicketPriceAndQuantity(
        quantity: initialTicketQuantity, ticketPrice: _initialTicketPrice);
    super.initState();
  }

  @override
  void dispose() {
    _ticketPriceController.dispose();
    _ticketQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(12),
          CustomTextField(
              hintText: "Enter ticket Quantity eg 4",
              labelText: "Quantity",
              isNumerical: true,
              keyboardType: TextInputType.number,
              onChanged: _onChangeTicketQuantity,
              controller: _ticketQuantity),
          const Gap(24),
          CustomTextField(
              hintText: "Enter per ticket price",
              labelText: "Price",
              isNumerical: true,
              keyboardType: TextInputType.number,
              onChanged: _onChangeTicketPrice,
              controller: _ticketPriceController),
          const Gap(18),
          const Divider(),
          const Gap(12),
          _buildLabel(),
          const Gap(32),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (user) => FilledButton(
                    onPressed: () => _saveAndPrintTicket(user!.uid),
                    child: const Text("save & print")),
                orElse: () => const FilledButton(
                    onPressed: null, child: Text("save & print")),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TicketTotalPriceCubit, TicketTotalPriceState>(
          bloc: _totalPriceCubit,
          builder: (context, priceState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomLabel(
                  labelName: "Price Per Ticket",
                  labelValue: priceState.pertTicketPrice.toString(),
                ),
                const Gap(4),
                CustomLabel(
                  labelName: "Quantity",
                  labelValue: priceState.quantity.toString(),
                ),
                const Gap(4),
                CustomLabel(
                  labelName: "Total price",
                  labelValue: priceState.totalPrice.toString(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onChangeTicketQuantity(p0) {
    _totalPriceCubit.changeTicketPriceAndQuantity(
        quantity: stringToIntParser(p0),
        ticketPrice: stringToDoubleParser(_ticketPriceController.text));
  }

  void _onChangeTicketPrice(p0) {
    _totalPriceCubit.changeTicketPriceAndQuantity(
        quantity: stringToIntParser(_ticketQuantity.text),
        ticketPrice: stringToDoubleParser(p0));
  }

  void _saveAndPrintTicket(String uid) {
    final Ticket ticket = Ticket(
        id: const Uuid().v1(),
        quantity: _ticketQuantity.text,
        ticketStatus: "available",
        pricePerTicket: _ticketPriceController.text,
        createdAt: DateTime.timestamp().toIso8601String());

    sl<TicketBloc>().add(TicketEvent.add(ticket));

    printDocument(context, ticket: ticket, uid: uid);
  }
}

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    Key? key,
    required this.labelName,
    required this.labelValue,
  }) : super(key: key);
  final String labelName;
  final String labelValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$labelName:",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap(8),
        Text(
          labelValue,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
