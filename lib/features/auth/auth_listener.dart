import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_trove/common/extensions.dart';
import 'package:ticket_trove/common/utils/toast_message.dart';
import 'package:ticket_trove/common/widgets/floating_loading_indicator.dart';
import 'package:ticket_trove/features/auth/blocs/auth_bloc/auth_bloc.dart';


void authListener(BuildContext context, AuthState state) {
  state.mapOrNull(
    loading: (_) => floatingLoadingIndicator(context),
    loaded: (_) {
      context.pop();

      // context.goNamed(AppRouteName.home);
    },
    error: (error) {
      toastMessage(context, data: error.failure.getMessage);
      context.pop();
    },
  );
}
