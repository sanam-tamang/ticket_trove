import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_trove/common/extensions.dart';
import 'package:ticket_trove/common/utils/toast_message.dart';
import 'package:ticket_trove/common/widgets/floating_loading_indicator.dart';
import 'package:ticket_trove/common/widgets/responsive.dart';
import 'package:ticket_trove/core/failure/failure.dart';
import 'package:ticket_trove/dependency_injection.dart';

import 'package:ticket_trove/features/profile/widgets/user_profile.dart';
import 'package:ticket_trove/features/ticket/blocs/ticket_bloc/ticket_bloc.dart';
import 'package:ticket_trove/features/ticket/show_ticket_dialog.dart';
import 'package:ticket_trove/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketBloc, TicketState>(
      listener: _ticketListener,
      child: Scaffold(
        appBar: AppBar(
          title: AutoResponsive(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ticket Trove',
                    style: Theme.of(context).textTheme.titleLarge),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: UserAvatar())
              ],
            ),
          ),
        ),
        body: AutoResponsive(
          child: Column(
            children: [
              kIsWeb
                  ? GestureDetector(
                      onTap: _gotoTicketPage,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Card.filled(
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Text("Create ticket"),
                          )),
                        ),
                      ))
                  : _buildScannerButton(),
            ],
          ),
        ),
        floatingActionButton: kIsWeb
            ? null
            : AutoResponsive(
                child: FilledButton.icon(
                    onPressed: _gotoTicketPage,
                    icon: const Icon(Icons.add),
                    label: const Text("Create ticket")),
              ),
      ),
    );
  }

  Container _buildScannerButton() {
    return Container(
      width: double.maxFinite,
      height: 200,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: BorderRadius.circular(25)),
      child: GestureDetector(
          onTap: _scanTicketAndUpdateTicket,
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            size: 80,
          )),
    );
  }

  void _gotoTicketPage() => context.pushNamed(AppRouteName.ticket);
  void _scanTicketAndUpdateTicket() {
    sl<TicketBloc>().add(const TicketEvent.updateTicketWithScannedResult());
  }

  void _ticketListener(BuildContext context, TicketState state) {
    state.mapOrNull(
      loading: (_) => floatingLoadingIndicator(context),
      loaded: (loaded) {
        context.pop();
        loaded.isTicketScanning
            ? showTicketDialog(context,
                isTicketAvailable: true, ticketQuantity: loaded.quantity)
            : toastMessage(context, data: loaded.message);
      },
      error: (error) {
        context.pop();

        error.failure is TicketAvailabilityFailure
            ? showTicketDialog(context, isTicketAvailable: false)
            : toastMessage(context, data: error.failure.getMessage);
      },
    );
  }
}
