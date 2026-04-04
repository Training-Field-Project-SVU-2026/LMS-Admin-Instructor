import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class LoginRightSide extends StatelessWidget {
  const LoginRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    final formWidth = getResponsiveSize(
      context: context,
      webSize: 480,
      mobileSize: 320,
    );

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.tr('login_success'),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.surface,
                ),
              ),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.go(AppRoutes.homeScreen);
        } else if (state is AuthError) {
          final errorMsg = state.message.toLowerCase();
          if (errorMsg.contains('verify') || errorMsg.contains('verified')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  context.tr('verify_email_message'),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.surface,
                  ),
                ),
                backgroundColor: context.colorScheme.primary,
                duration: const Duration(seconds: 4),
              ),
            );
            // TODO: Navigate to verify otp screen
            // context.pushNamed(
            //   AppRoutes.verifyOtpScreen,
            //   extra: {'email': authBloc.emailController.text},
            // );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.surface,
                  ),
                ),
                backgroundColor: context.colorScheme.error,
              ),
            );
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(48),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(48),
          ),
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
                      key: authBloc.loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Clean and welcoming header
                          Text(
                            context.tr('welcome_back'),
                            style: context.textTheme.displaySmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              fontSize: getResponsiveSize(
                                context: context,
                                webSize: 36,
                                mobileSize: 24,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            context.tr('sign_in_subtitle'),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontSize: getResponsiveSize(
                                context: context,
                                webSize: 16,
                                mobileSize: 14,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 56),
                      
                          // Inputs
                          CustomTextFormField(
                            controller: authBloc.emailController,
                            txt: context.tr('email_address'),
                            hint: context.tr('email_hint'),
                            prefixIcon: Icons.alternate_email_rounded,
                            w: formWidth,
                          ),
                          const SizedBox(height: 24),
                          CustomTextFormField(
                            controller: authBloc.passwordController,
                            txt: context.tr('password'),
                            hint: context.tr('password_hint'),
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
                                context.tr('forgot_password'),
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
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final isLoading = state is AuthLoading;
                              return Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.colorScheme.primary
                                          .withValues(alpha: 0.25),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: CustomPrimaryButton(
                                  text: isLoading
                                      ? context.tr('signing_in')
                                      : context.tr('sign_in_to_dashboard'),
                                  onTap: isLoading
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          context.read<AuthBloc>().add(
                                            LoginEvent(),
                                          );
                                        },
                                  suffixIcon: isLoading
                                      ? SizedBox(
                                          width: 10.w,
                                          height: 10.w,
                                          child: CircularProgressIndicator(
                                            color: context.colorScheme.onPrimary,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Icon(
                                          Icons.arrow_forward,
                                          color: context.colorScheme.surface,
                                          size: 10.w,
                                        ),
                                  width: formWidth,
                                ),
                              );
                            },
                          ),
                      
                          const SizedBox(height: 32),
                      
                          // Navigation to Register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                context.tr('dont_have_account'),
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
                                  context.tr('sign_up'),
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
