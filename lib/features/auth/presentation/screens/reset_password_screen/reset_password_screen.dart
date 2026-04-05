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

    return Scaffold(
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
                    color: context.colorScheme.primary.withValues(alpha: 0.15),
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
                          fontSize: getResponsiveSize(
                            context: context,
                            webSize: 32,
                            mobileSize: 28,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),

                      Text(
                        context.tr('reset_password_subtitle'),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontSize: getResponsiveSize(
                            context: context,
                            webSize: 16,
                            mobileSize: 14,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 48.h),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 4.0),
                        child: Text(
                          context.tr('new_password').toUpperCase(),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        controller: authBloc.newPasswordController,
                        txt: "",
                        hint: context.tr('new_password_hint'),
                        prefixIcon: Icons.lock_outline_rounded,
                        suffixIcon: Icons.visibility_off_outlined,
                        w: formWidth,
                      ),
                      SizedBox(height: 20.h),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 4.0),
                        child: Text(
                          context.tr('confirm_password').toUpperCase(),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        controller: authBloc.confirmNewPasswordController,
                        txt: "",
                        hint: context.tr('confirm_password_hint'),
                        prefixIcon: Icons.lock_outline_rounded,
                        suffixIcon: Icons.visibility_off_outlined,
                        w: formWidth,
                      ),

                      SizedBox(height: 32.h),

                      CustomPrimaryButton(
                        text: context.tr('save_password'),
                        onTap: () {
                          if (authBloc.resetPasswordFormKey.currentState
                                  ?.validate() ??
                              false) {
                            if (authBloc.newPasswordController.text !=
                                authBloc.confirmNewPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Passwords do not match",
                                    style: context.textTheme.labelSmall
                                        ?.copyWith(
                                          color: context.colorScheme.surface,
                                        ),
                                  ),
                                  backgroundColor: context.colorScheme.error,
                                ),
                              );
                              return;
                            }

                            FocusScope.of(context).unfocus();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Password changed successfully!",
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorScheme.surface,
                                  ),
                                ),
                                backgroundColor: context.colorScheme.secondary,
                              ),
                            );

                            context.go(AppRoutes.loginScreen);
                          }
                        },
                        width: formWidth,
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
                              fontSize: 14,
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
    );
  }
}
