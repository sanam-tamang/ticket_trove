import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_trove/common/blocs/user_bloc/user_bloc.dart';
import 'package:ticket_trove/common/extensions.dart';
import 'package:ticket_trove/common/utils/toast_message.dart';
import 'package:ticket_trove/dependency_injection.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({super.key});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  late UserBloc _userBloc;
  @override
  void initState() {
    _userBloc = sl<UserBloc>()..add(const UserEvent.getUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: _userBloc,
      listener: (context, state) {
        state.mapOrNull(
            error: (error) =>
                toastMessage(context, data: error.failure.getMessage));
      },
      builder: (context, state) {
        return state.maybeMap(
            loading: (_) => const CircularProgressIndicator(),
            loaded: (loaded) => _buildUserAvatar(loaded.user),
            orElse: () => _noPictureAvatar(context));
      },
    );
  }

  CircleAvatar _noPictureAvatar(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      child: Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }

  Widget _buildUserAvatar(User? user) {
    return user?.photoURL != null
        ? CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(user!.photoURL!),
          )
        : _noPictureAvatar(context);
  }
}
