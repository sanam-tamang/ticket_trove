import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_trove/common/typedef.dart';
import 'package:ticket_trove/core/failure/failure.dart';

abstract class BaseUserRepository {
  FutureEither<User?> getCurrentUser();
  FutureEither<User?> saveCurrentUser(User? user);
}

class UserRepository implements BaseUserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;
  @override
  FutureEither<User?> getCurrentUser() async {
    try {
      return Right(_firebaseAuth.currentUser);
    } catch (e) {
      return Left(FailureWithMessage(e.toString()));
    }
  }
  
  @override
  FutureEither<User?> saveCurrentUser(User? user) {
    // TODO: implement saveCurrentUser
    throw UnimplementedError();
  }
}
