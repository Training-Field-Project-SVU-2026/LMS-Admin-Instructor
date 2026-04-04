import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class LoginRightSide extends StatefulWidget {
  const LoginRightSide({super.key});

  @override
  State<LoginRightSide> createState() => _LoginRightSideState();
}

class _LoginRightSideState extends State<LoginRightSide> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formWidth = getResponsiveSize(
      context: context,
      webSize: 480, // slightly narrower for a sleek premium form look
      tabletSize: 400,
      mobileSize: 320,
    );

    return Container(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Clean and welcoming header
                      Text(
                        'Welcome back',
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
                        'Sign in to your account and continue your journey.',
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
                      const SizedBox(height: 56),

                      // Inputs
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
                        hint: 'Enter your password',
                        prefixIcon: Icons.lock_outline_rounded,
                        suffixIcon: Icons.visibility_off_outlined,
                        w: formWidth,
                      ),

                      const SizedBox(height: 16),

                      // Actions
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.go(AppRoutes.forgotPasswordScreen);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: context.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Bold Premium Login Button
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.primary.withValues(
                                alpha: 0.25,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomPrimaryButton(
                          text: 'Sign in to Dashboard',
                          onTap: () {},
                          suffixIcon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 18,
                          ),
                          width: formWidth,
                        ),
                      ),
                      
                      const SizedBox(height: 32),

                      // Navigation to Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account? ',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go(AppRoutes.registerScreen);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Sign Up',
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
    );
  }
}
