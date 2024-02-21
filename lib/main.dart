import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ticket_trove/common/blocs/user_bloc/user_bloc.dart';

import 'package:ticket_trove/dependency_injection.dart' as di;
import 'package:ticket_trove/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:ticket_trove/features/ticket/blocs/ticket_bloc/ticket_bloc.dart';
import 'package:ticket_trove/firebase_options.dart';

import 'package:ticket_trove/router.dart';
import 'features/ticket/blocs/ticket_total_price_cubit/ticket_total_price_cubit.dart';

Future<void> main() async {
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
   FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<TicketTotalPriceCubit>()),
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<TicketBloc>()),
        BlocProvider(create: (context) => di.sl<UserBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Ticket Trove',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        routerConfig: AppRoute.call(),
      ),
    );
  }
}
