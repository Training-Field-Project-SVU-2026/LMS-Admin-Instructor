import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class ForgotPasswordCard extends StatefulWidget {
  const ForgotPasswordCard({super.key});

  @override
  State<ForgotPasswordCard> createState() => _ForgotPasswordCardState();
}

class _ForgotPasswordCardState extends State<ForgotPasswordCard> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = getResponsiveSize(
      context: context,
      webSize: 520,
      tabletSize: 480,
      mobileSize: double.infinity,
    );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 40 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: Padding(
            padding: EdgeInsets.all(
              getResponsiveSize(
                context: context,
                webSize: 48,
                tabletSize: 40,
                mobileSize: 32,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Back Button Row
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => context.go(AppRoutes.loginScreen),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: context.colorScheme.onSurface,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: context.colorScheme.onSurface.withValues(alpha: 0.05),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Fancy Central Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: _FloatingKeyIcon(),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Header Typography
                  Text(
                    'Forgot Password?',
                    style: context.textTheme.displaySmall?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      fontSize: getResponsiveSize(
                        context: context,
                        webSize: 32,
                        tabletSize: 28,
                        mobileSize: 24,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No worries, we\'ll send you reset instructions.\nPlease enter your registered email address.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      height: 1.5,
                      fontSize: getResponsiveSize(
                        context: context,
                        webSize: 16,
                        tabletSize: 16,
                        mobileSize: 14,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // Input Field
                  CustomTextFormField(
                    controller: _emailController,
                    txt: 'Email Address',
                    hint: 'name@example.com',
                    prefixIcon: Icons.alternate_email_rounded,
                    w: cardWidth,
                  ),

                  const SizedBox(height: 32),

                  // Submit Button
                  Container(
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
                      text: 'Send Reset Link',
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Handle forget password dispatch here
                        }
                      },
                      width: cardWidth,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Return Link
                  TextButton(
                    onPressed: () => context.go(AppRoutes.loginScreen),
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.primary,
                    ),
                    child: Text(
                      'Return to Sign In',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingKeyIcon extends StatefulWidget {
  @override
  State<_FloatingKeyIcon> createState() => _FloatingKeyIconState();
}

class _FloatingKeyIconState extends State<_FloatingKeyIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )..repeat(reverse: true);

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(0, -0.1),
    end: const Offset(0, 0.1),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Icon(
        Icons.key_rounded,
        size: 48,
        color: context.colorScheme.primary,
      ),
    );
  }
}
