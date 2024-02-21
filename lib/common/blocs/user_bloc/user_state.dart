part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(User? user) = _Loaded;
  const factory UserState.error(Failure failure) = _Error;
}
