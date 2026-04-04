import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class RegisterRightSide extends StatefulWidget {
  const RegisterRightSide({super.key});

  @override
  State<RegisterRightSide> createState() => _RegisterRightSideState();
}

class _RegisterRightSideState extends State<RegisterRightSide> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formWidth = getResponsiveSize(
      context: context,
      webSize: 480,
      tabletSize: 400,
      mobileSize: 320,
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRoutes.homeScreen);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(48)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(left: Radius.circular(48)),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: formWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 24.0,
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(30 * (1 - value), 0),
                          child: child,
                        ),
                      );
                    },
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header
                          Text(
                            'Create an Account',
                            style: context.textTheme.displaySmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              fontSize: getResponsiveSize(
                                context: context,
                                webSize: 36,
                                tabletSize: 28,
                                mobileSize: 24,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Enter your details below to join us.',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: getResponsiveSize(
                                context: context,
                                webSize: 16,
                                tabletSize: 16,
                                mobileSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 48),

                          // Inputs
                          CustomTextFormField(
                            controller: _nameController,
                            txt: 'Full Name',
                            hint: 'John Doe',
                            prefixIcon: Icons.person_outline_rounded,
                            w: formWidth,
                          ),
                          const SizedBox(height: 24),
                          CustomTextFormField(
                            controller: _emailController,
                            txt: 'Email Address',
                            hint: 'name@example.com',
                            prefixIcon: Icons.alternate_email_rounded,
                            w: formWidth,
                          ),
                          const SizedBox(height: 24),
                          CustomTextFormField(
                            controller: _passwordController,
                            txt: 'Password',
                            hint: 'Create a password',
                            prefixIcon: Icons.lock_outline_rounded,
                            suffixIcon: Icons.visibility_off_outlined,
                            w: formWidth,
                          ),

                          const SizedBox(height: 48),

                          // Register Button
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              return Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.colorScheme.primary.withValues(alpha: 0.25),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CustomPrimaryButton(
                                  text: 'Sign Up',
                                  onTap: () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      context.read<AuthBloc>().add(
                                        RegisterEvent(
                                          name: _nameController.text,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                  suffixIcon: const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18,
                                  ),
                                  width: formWidth,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 32),

                          // Navigation to Login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.go(AppRoutes.loginScreen);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Sign In',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
