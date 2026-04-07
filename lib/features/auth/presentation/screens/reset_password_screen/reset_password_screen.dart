import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/data/model/reset_password_request_model.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/auth/utils/auth_validator.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formWidth = getResponsiveSize(
      context: context,
      webSize: 400,
      mobileSize: 350,
    );

    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('password_reset_success')),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.go(AppRoutes.loginScreen);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primary.withValues(alpha: 0.2),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 100,
                      spreadRadius: 50,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primary.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withValues(
                        alpha: 0.15,
                      ),
                      blurRadius: 120,
                      spreadRadius: 60,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: formWidth),
                  child: Form(
                    key: authBloc.resetPasswordFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.tr('reset_password_title'),
                          style: context.textTheme.displaySmall?.copyWith(
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          context.tr('reset_password_subtitle'),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 48.h),

                        // OTP Code Field
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 4.0,
                            left: 4.0,
                          ),
                          child: Text(
                            context.tr('otp_code').toUpperCase(),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          controller: authBloc.otpController,
                          txt: "",
                          hint: context.tr('otp_hint'),
                          prefixIcon: Icons.verified_user_outlined,
                          w: formWidth,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Verification code is required';
                            }
                            if (value.length < 6) {
                              return 'Enter a valid 6-digit code';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),

                        // New Password Field
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 4.0,
                            left: 4.0,
                          ),
                          child: Text(
                            context.tr('new_password').toUpperCase(),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          controller: authBloc.newPasswordController,
                          txt: "",
                          hint: context.tr('new_password_hint'),
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          w: formWidth,
                          // validator: validatePassword,
                        ),
                        SizedBox(height: 20.h),

                        // Confirm Password Field
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 4.0,
                            left: 4.0,
                          ),
                          child: Text(
                            context.tr('confirm_password').toUpperCase(),
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        CustomTextFormField(
                          controller: authBloc.confirmNewPasswordController,
                          txt: "",
                          hint: context.tr('confirm_password_hint'),
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          w: formWidth,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please confirm your password';
                          //   }
                          //   if (value != authBloc.newPasswordController.text) {
                          //     return 'Passwords do not match';
                          //   }
                          //   return null;
                          // },
                        ),

                        SizedBox(height: 32.h),

                        // Submit Button
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;
                            return CustomPrimaryButton(
                              text: isLoading
                                  ? context.tr('saving')
                                  : context.tr('save_password'),
                              onTap: isLoading
                                  ? null
                                  : () {
                                      if (authBloc
                                              .resetPasswordFormKey
                                              .currentState
                                              ?.validate() ??
                                          false) {
                                        FocusScope.of(context).unfocus();
                                        authBloc.add(
                                          ResetPasswordEvent(
                                            requestModel:
                                                ResetPasswordRequestModel(
                                                  otp: authBloc
                                                      .otpController
                                                      .text
                                                      .trim(),
                                                  newPassword: authBloc
                                                      .newPasswordController
                                                      .text
                                                      .trim(),
                                                ),
                                          ),
                                        );
                                      }
                                    },
                              width: formWidth,
                            );
                          },
                        ),

                        SizedBox(height: 32.h),

                        Center(
                          child: TextButton.icon(
                            onPressed: () {
                              context.go(AppRoutes.loginScreen);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 14,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            label: Text(
                              context.tr('go_back_to_login'),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor:
                                  context.colorScheme.onSurfaceVariant,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              splashFactory: NoSplash.splashFactory,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
