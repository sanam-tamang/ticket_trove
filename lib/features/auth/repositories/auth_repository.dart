import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticket_trove/common/typedef.dart';
import 'package:ticket_trove/common/utils/firebase_simpliefield_exception_message.dart';
import 'package:ticket_trove/core/failure/failure.dart';

abstract class BaseAuthRepository {
  FutureEither<User?> signUp(String email, String password);
  FutureEither<User?> signIn(String email, String password);
}

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  FutureEither<User?> signUp(String email, String password) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore
          .collection("user")
          .doc(userCredential.user?.uid)
          .set({"email": email, "uid": userCredential.user?.uid});

      // Return Right with user if sign up successful
      return Right(userCredential.user);
    } on FirebaseException catch (e) {
      return Left(
          FailureWithMessage(getFirebaseSimplifiedExceptionMessage(e.message)));
    } catch (e) {
      // Return Left with error message if sign up fails
      return Left(FailureWithMessage(e.toString()));
    }
  }

  @override
  FutureEither<User?> signIn(String email, String password) async {
    try {
      // Sign in user with email and password
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return Right with user if sign in successful
      return Right(userCredential.user);
    } on FirebaseException catch (e) {
      return Left(
          FailureWithMessage(getFirebaseSimplifiedExceptionMessage(e.message)));
    } catch (e) {
      // Return Left with error message if sign in fails
      return Left(FailureWithMessage(e.toString()));
    }
  }
}
