import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ticket_trove/core/failure/failure.dart';
import 'package:ticket_trove/core/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final BaseUserRepository _userRepository;
  UserBloc(this._userRepository) : super(const _Initial()) {
    on<UserEvent>((event, emit) async {
      await event.map(
        getUser: (event) async => await _onGetUser(event, emit),
      );
    });
  }

  Future<void> _onGetUser(_GetUser event, Emitter<UserState> emit) async {
    emit(const UserState.loading());
    final failureOrUser = await _userRepository.getCurrentUser();
    failureOrUser.fold((l) => emit(UserState.error(l)),
        (user) => emit(UserState.loaded(user)));
  }
}
