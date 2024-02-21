import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticket_trove/core/failure/failure.dart';
import 'package:ticket_trove/features/qr_code_scanner/utils.dart';
import 'package:ticket_trove/features/ticket/models/ticket.dart';
import 'package:ticket_trove/features/ticket/repositories/ticket_repository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';
part 'ticket_bloc.freezed.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final BaseTicketRepository _repository;
  TicketBloc(this._repository) : super(const _Initial()) {
    on<TicketEvent>((event, emit) async {
      await event.map(
        add: (event) async => await _onAdd(event, emit),
        update: (event) async => await _onUpdate(event, emit),
        updateTicketWithScannedResult: (event) async =>
            _onUpdateTicketWithScannedResult(event, emit),
      );
    });
  }

  Future<void> _onAdd(_Add event, Emitter<TicketState> emit) async {
    emit(const TicketState.loading());

    final failureOrSuccess = await _repository.addTicket(event.ticket);
    failureOrSuccess.fold((l) => emit(TicketState.error(l)),
        (message) => emit(TicketState.loaded(message: message)));
  }

  Future<void> _onUpdate(_Update event, Emitter<TicketState> emit) async {
    emit(const TicketState.loading());
    final failureOrSuccess = await _repository.updateTicket(event.ticket);
    failureOrSuccess.fold((l) => emit(TicketState.error(l)),
        (message) => emit(TicketState.loaded(message: message)));
  }

  Future<void> _onUpdateTicketWithScannedResult(
      _UpdateTicketWithScannedResult event, Emitter<TicketState> emit) async {
    try {
      final ticketScannedData = await scanQR();
      emit(const TicketState.loading());

      final scannedMap = jsonDecode(ticketScannedData);

      final String userId = scannedMap['userId'];
      final String ticketId = scannedMap['id'];
      final String quantity = scannedMap['quantity'];
      final failureOrSuccess = await _repository.updateTicketStatus(
          ticketId: ticketId, userId: userId);

      failureOrSuccess.fold((l) => emit(TicketState.error(l)),
          (message) => emit(TicketState.loaded(message: message, isTicketScanning: true, quantity: quantity)));
    } on FormatException {
      emit(TicketState.error(FailureWithMessage("Unable to read ticket")));
    } catch (e) {
      emit(TicketState.error(FailureWithMessage(e.toString())));
    }
  }
}
