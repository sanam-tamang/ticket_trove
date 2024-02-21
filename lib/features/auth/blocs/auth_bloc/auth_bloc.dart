import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticket_trove/core/failure/failure.dart';
import 'package:ticket_trove/features/auth/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final BaseAuthRepository _auth;
  AuthBloc(this._auth) : super(const _Initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
     
        signIn: (event) async => await _onSignIn(event, emit),
        signUp: (event) async => await _onSignUp(event, emit),
      );
    });
  }

  Future<void> _onSignIn(_SignIn event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final failureOrSuccess = await _auth.signIn(event.email, event.password);
    failureOrSuccess.fold((l) {
      emit(AuthState.error(l));
    }, (user) {
      emit(AuthState.loaded(user));
    });
  }

  Future<void> _onSignUp(_SignUp event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final failureOrSuccess = await _auth.signUp(event.email, event.password);
    failureOrSuccess.fold((l) {
      emit(AuthState.error(l));
    }, (user) {
      emit(AuthState.loaded(user));
    });
  }

}
