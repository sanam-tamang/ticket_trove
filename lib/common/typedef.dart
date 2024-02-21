
import 'package:dartz/dartz.dart';
import 'package:ticket_trove/core/failure/failure.dart';

typedef FutureEither<Type> = Future<Either<Failure, Type>>;
