import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:ticket_trove/common/blocs/user_bloc/user_bloc.dart';
import 'package:ticket_trove/core/repositories/user_repository.dart';
import 'package:ticket_trove/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:ticket_trove/features/auth/repositories/auth_repository.dart';
import 'package:ticket_trove/features/ticket/blocs/ticket_bloc/ticket_bloc.dart';
import 'package:ticket_trove/features/ticket/repositories/ticket_repository.dart';

import 'features/ticket/blocs/ticket_total_price_cubit/ticket_total_price_cubit.dart';

final sl = GetIt.instance;

void init() {
  //blocs
  sl.registerFactory(() => TicketTotalPriceCubit());
  sl.registerLazySingleton(() => AuthBloc(sl()));
  sl.registerLazySingleton(() => TicketBloc(sl()));
  sl.registerLazySingleton(() => UserBloc(sl()));
  //repositories
  sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<BaseTicketRepository>(
      () => TicketRepository(firestore: sl(), user: sl()));
  sl.registerLazySingleton<BaseUserRepository>(
      () => UserRepository(firebaseAuth: sl()));

//external
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
