import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_reset_password_request_model.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
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
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: getResponsiveSize(
              context: context,
              webSize: 48,
              mobileSize: 64,
            ),
            vertical: 32,
          ),
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
                    style: context.textTheme.headlineMedium!.copyWith(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.tr('reset_password_subtitle'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 68.h),

                  CustomTextFormField(
                    controller: authBloc.newPasswordController,
                    txt: context.tr('new_password'),
                    hint: context.tr('new_password_hint'),
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                    w: formWidth,
                    //TODO: add validation
                    // validator: validatePassword,
                  ),
                  SizedBox(height: 18.h),

                  CustomTextFormField(
                    controller: authBloc.confirmNewPasswordController,
                    txt: context.tr('confirm_password'),
                    hint: context.tr('confirm_password_hint'),
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                    w: formWidth,
                    //TODO: add validation
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

                  SizedBox(height: 68.h),

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
                                if (authBloc.resetPasswordFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  FocusScope.of(context).unfocus();
                                  authBloc.add(
                                    ResetPasswordEvent(
                                      requestModel: ResetPasswordRequestModel(
                                        otp: authBloc.otpController.text.trim(),
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
                        size: 10.sp,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      label: Text(
                        context.tr('go_back_to_login'),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: context.colorScheme.onSurfaceVariant,
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
    );
  }
}
