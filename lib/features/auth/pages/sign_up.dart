import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ticket_trove/common/utils/validation.dart';
import 'package:ticket_trove/common/widgets/custom_text_field.dart';
import 'package:ticket_trove/dependency_injection.dart';
import 'package:ticket_trove/features/auth/auth_listener.dart';
import 'package:ticket_trove/features/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:ticket_trove/router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Sign up",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const Gap(32),
                CustomTextField(
                  hintText: "Enter your email",
                  labelText: "Email",
                  autofillHints: const [AutofillHints.email],
                  controller: _emailController,
                  validator: CustomValidator.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const Gap(16),
                CustomTextField(
                    hintText: "Enter your password",
                    labelText: "password",
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    validator: CustomValidator.password,
                  keyboardType: TextInputType.visiblePassword,

                    controller: _passwordController),
                const Gap(32),
                BlocListener<AuthBloc, AuthState>(
                  listener: authListener,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: signup, child: const Text("Sign up")),
                  ),
                ),
                const Gap(16),
                _buildHaveAnAccountWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _buildHaveAnAccountWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => context.goNamed(AppRouteName.signin),
        child: RichText(
          text: TextSpan(
              text: "Already have an account?",
              children: const [
                TextSpan(
                    text: " Sign in", style: TextStyle(color: Colors.blue)),
              ],
              style: Theme.of(context).textTheme.labelLarge),
        ),
      ),
    );
  }

  void signup() {
    if (!_formKey.currentState!.validate()) return;
    sl<AuthBloc>().add(AuthEvent.signUp(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text,
        name: ""));
  }
}
