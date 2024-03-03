// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:ticket_trove/common/typedef.dart';
import 'package:ticket_trove/common/utils/firebase_simpliefield_exception_message.dart';
import 'package:ticket_trove/common/utils/string_parser.dart';
import 'package:ticket_trove/core/failure/failure.dart';
import 'package:ticket_trove/core/repositories/user_repository.dart';
import 'package:ticket_trove/features/ticket/models/ticket.dart';

abstract class BaseTicketRepository {
  FutureEither<String> addTicket(Ticket ticket);
  FutureEither<String> updateTicket(Ticket ticket);
  FutureEither<String> updateTicketStatus(
      {required String userId, required String ticketId});
}

class TicketRepository implements BaseTicketRepository {
  final FirebaseFirestore _firestore;
  final BaseUserRepository _user;
  TicketRepository(
      {required FirebaseFirestore firestore, required BaseUserRepository user})
      : _firestore = firestore,
        _user = user;

  @override
  FutureEither<String> addTicket(Ticket ticket) async {
    try {
      final uid = await _getUid();
      await _firestore
          .collection("user")
          .doc(uid)
          .collection('ticket')
          .doc(ticket.id)
          .set(ticket.toJson()..addAll({"userId": uid}));
      await _firestore
          .collection("user")
          .doc(uid)
          .collection('box-office')
          .doc(uid)
          .set({
        "totalTicketsQuantity":
            FieldValue.increment(stringToIntParser(ticket.quantity)),
        "turnOver": FieldValue.increment(stringToDoubleParser(ticket.quantity) *
            stringToDoubleParser(ticket.pricePerTicket))
      }, SetOptions(merge: true));

      return const Right("Ticket created");
    } on FirebaseException catch (e) {
      return Left(FailureWithMessage(
          getFirebaseSimplifiedExceptionMessage(e.toString())));
    } catch (e) {
      return Left(FailureWithMessage(e.toString()));
    }
  }

  @override
  FutureEither<String> updateTicket(Ticket ticket) async {
    try {
      final uid = await _getUid();

      await _firestore
          .collection("user")
          .doc(uid)
          .collection('ticket')
          .doc(ticket.id)
          .update(ticket.toJson());
      return const Right("Ticket updated");
    } on FirebaseException catch (e) {
      return Left(FailureWithMessage(
          getFirebaseSimplifiedExceptionMessage(e.toString())));
    } catch (e) {
      return Left(FailureWithMessage(e.toString()));
    }
  }

  Future<String?> _getUid() async {
    final user = await _user.getCurrentUser();
    return user.fold((l) => throw l, (r) => r?.uid);
  }

  @override
  FutureEither<String> updateTicketStatus(
      {required String userId, required String ticketId}) async {
    try {
      final uid = await _getUid();

      final ticketData = await _firestore
          .collection("user")
          .doc(uid)
          .collection('ticket')
          .doc(ticketId)
          .get();
      final mapTicket = ticketData.data();
      if (mapTicket?['userId'] == userId &&
          mapTicket?['ticketStatus'] == "available") {
        await _firestore
            .collection("user")
            .doc(uid)
            .collection('ticket')
            .doc(ticketId)
            .update({
          'ticketStatus': "booked",
        });
        return const Right("Ticket is available");
      } else {
        return Left(TicketAvailabilityFailure());
      }
    } on FirebaseException catch (e) {
      return Left(FailureWithMessage(
          getFirebaseSimplifiedExceptionMessage(e.toString())));
    } catch (e) {
      return Left(FailureWithMessage(e.toString()));
    }
  }
}
