part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.loaded(User? user) = _Loaded;
  const factory AuthState.error(Failure failure) = _Error;
}
