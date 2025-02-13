import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_trove/common/widgets/custom_text_field.dart';
import 'package:ticket_trove/common/widgets/responsive.dart';
import 'package:ticket_trove/dependency_injection.dart';
import 'package:ticket_trove/features/auth/auth_listener.dart';
import 'package:ticket_trove/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:ticket_trove/router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoResponsive(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const Gap(32),
                CustomTextField(
                    hintText: "Enter your email",
                    labelText: "Email",
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController),
                const Gap(16),
                CustomTextField(
                  hintText: "Enter your password",
                  labelText: "password",
                  obscureText: true,
                  autofillHints: const [AutofillHints.password],
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const Gap(32),
                BlocListener<AuthBloc, AuthState>(
                  listener: authListener,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: signIn, child: const Text("Sign in")),
                  ),
                ),
                const Gap(16),
                _buildDoNotHaveAnAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _buildDoNotHaveAnAccount(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => context.goNamed(AppRouteName.signup),
        child: RichText(
          text: TextSpan(
              text: "Don't have an account?",
              children: const [
                TextSpan(
                    text: " Sign up", style: TextStyle(color: Colors.blue)),
              ],
              style: Theme.of(context).textTheme.labelLarge),
        ),
      ),
    );
  }

  void signIn() {
    sl<AuthBloc>().add(AuthEvent.signIn(
      email: _emailController.text.trim().toLowerCase(),
      password: _passwordController.text,
    ));
  }
}
