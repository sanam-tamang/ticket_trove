import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_trove/common/bloc_listenable.dart';
import 'package:ticket_trove/common/blocs/user_bloc/user_bloc.dart';
import 'package:ticket_trove/common/utils/extensions.dart';
import 'package:ticket_trove/common/widgets/dialog_page.dart';
import 'package:ticket_trove/dependency_injection.dart';
import 'package:ticket_trove/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:ticket_trove/features/auth/pages/sign_in.dart';
import 'package:ticket_trove/features/auth/pages/sign_up.dart';

import 'package:ticket_trove/features/home/pages/home_page.dart';
import 'package:ticket_trove/features/ticket/pages/ticket.dart';

class AppRouteName {
  static const String home = "home";
  static const String signup = "signup";
  static const String signin = "signin";
  static const String ticket = "ticket";
  static const String editTicket = "edit-ticket";
  static const String scannTicket = "scan-ticket";
}

class AppRoute {
  static GoRouter call() {
    return GoRouter(
        initialLocation: AppRouteName.signin.path,
        redirect: (context, state) {
          final currentPath = state.uri.path;
          bool isAuthPath = currentPath == AppRouteName.signin.path ||
              currentPath == AppRouteName.signup.path;

          if (isAuthPath) {
            return sl<AuthBloc>().state.maybeWhen(
                loaded: (_) => AppRouteName.home.rootPath,
                orElse: () => sl<UserBloc>().state.maybeWhen(
                    loaded: (user) => AppRouteName.home.rootPath,
                    orElse: () => null));
          }

          return null;
        },
        refreshListenable: BlocListenable(sl<AuthBloc>()),
        routes: [
          GoRoute(
            path: AppRouteName.home.rootPath,
            name: AppRouteName.home,
            pageBuilder: (context, state) {
              return _customPage(state, child: const HomePage());
            },
          ),
          GoRoute(
            path: AppRouteName.signup.path,
            name: AppRouteName.signup,
            pageBuilder: (context, state) {
              return _customPage(state, child: const SignUpPage());
            },
          ),
          GoRoute(
            path: AppRouteName.signin.path,
            name: AppRouteName.signin,
            pageBuilder: (context, state) {
              return _customPage(state, child: const SignInPage());
            },
          ),
          GoRoute(
            path: AppRouteName.ticket.path,
            name: AppRouteName.ticket,
            pageBuilder: (context, state) {
              return DialogPage(
                builder: (context) => const TicketPage(),
              );
            },
          ),
        ]);
  }

  static Page<dynamic> _customPage(GoRouterState state,
      {required Widget child}) {
    return MaterialPage(key: state.pageKey, child: child);
  }
}
