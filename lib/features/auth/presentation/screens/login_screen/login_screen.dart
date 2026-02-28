import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_admin_instructor/features/widgets/custom_viewer.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go(AppRoutes.homeScreen);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TextFormField(
                //   controller: _emailController,
                //   decoration: const InputDecoration(labelText: 'Email'),
                //   validator: (value) {
                //     if (value == null || value.isEmpty)
                //       return 'Please enter email';
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: _passwordController,
                //   decoration: const InputDecoration(labelText: 'Password'),
                //   obscureText: true,
                //   validator: (value) {
                //     if (value == null || value.isEmpty)
                //       return 'Please enter password';
                //     return null;
                //   },
                // ),
                // const SizedBox(height: 24),
                // BlocBuilder<AuthBloc, AuthState>(
                //   builder: (context, state) {
                //     if (state is AuthLoading) {
                //       return const CircularProgressIndicator();
                //     }
                //     return ElevatedButton(
                //       onPressed: () {
                //         if (_formKey.currentState!.validate()) {
                //           context.read<AuthBloc>().add(
                //             LoginEvent(
                //               email: _emailController.text,
                //               password: _passwordController.text,
                //             ),
                //           );
                //         }
                //       },
                //       child: const Text('Login'),
                //     );
                //   },
                // ),
                // TextButton(
                //   onPressed: () => context.push(AppRoutes.registerScreen),
                //   child: const Text('Don\'t have an account? Register'),
                // ),
                CustomButton(
                  txt: 'Taha',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomViewer()),
                    );
                  },
                  color: context.colorScheme.secondary,
                  // h: 120,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  txt: "taha",
                  hint: "Taha@mail.com",
                  controller: _emailController,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
