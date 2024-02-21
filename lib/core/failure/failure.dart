import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {}

class TicketAvailabilityFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class FailureWithMessage extends Failure {
  final String? message;
  FailureWithMessage(this.message);
  @override
  String toString() {
    return "$message";
  }

  @override
  List<Object?> get props => [];
}
