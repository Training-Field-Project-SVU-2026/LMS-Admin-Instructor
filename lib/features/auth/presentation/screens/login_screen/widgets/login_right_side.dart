import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/auth/utils/auth_validator.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class LoginRightSide extends StatelessWidget {
  const LoginRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    final formWidth = getResponsiveSize(
      context: context,
      webSize: 450,
      mobileSize: 350,
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
          context.go(AppRoutes.navBar);
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
          borderRadius: context.isDesktop
              ? BorderRadius.horizontal(left: Radius.circular(30.r))
              : BorderRadius.zero,
        ),
        child: ClipRRect(
          borderRadius: context.isDesktop
              ? BorderRadius.horizontal(left: Radius.circular(30.r))
              : BorderRadius.zero,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: formWidth),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getResponsiveSize(
                      context: context,
                      webSize: 48,
                      mobileSize: 24,
                    ),
                    vertical: getResponsiveSize(
                      context: context,
                      webSize: 48,
                      mobileSize: 16,
                    ),
                  ),
                  child: Form(
                    key: authBloc.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.tr('welcome_back'),
                          style: context.textTheme.displaySmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          context.tr('sign_in_subtitle'),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 45.h),

                        CustomTextFormField(
                          controller: authBloc.emailController,
                          txt: context.tr('email_address'),
                          hint: context.tr('email_hint'),
                          prefixIcon: Icons.alternate_email_rounded,
                          w: formWidth,
                          validator: validateEmail,
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: authBloc.passwordController,
                          txt: context.tr('password'),
                          hint: context.tr('password_hint'),
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: Icons.visibility_off_outlined,
                          w: formWidth,
                          // validator: validatePassword,
                        ),

                        SizedBox(height: 12.h),

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
                              style: context.textTheme.bodySmall?.copyWith(),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

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

                        SizedBox(
                          height: getResponsiveSize(
                            context: context,
                            webSize: 32,
                            mobileSize: 12,
                          ),
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
    );
  }
}
