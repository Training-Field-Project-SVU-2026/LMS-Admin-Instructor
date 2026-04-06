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

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.secondary,
            ),
          );

          context.go(
            AppRoutes.verifyOtpScreen,
            extra: {
              'email': authBloc.emailController.text.trim(),
            },
          );
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
                  key: authBloc.forgetPasswordFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.tr('forgot_password_title'),
                        style: context.textTheme.displaySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),

                      Text(
                        context.tr('forgot_password_desc'),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 48.h),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 4.0),
                        child: Text(
                          context.tr('email_address').toUpperCase(),
                          style: context.textTheme.labelSmall?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w700,

                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        controller: authBloc.emailController,
                        txt: "",
                        hint: context.tr('email_address'),
                        prefixIcon: Icons.email_outlined,
                        w: formWidth,
                        validator: validateEmail,
                      ),
                      SizedBox(height: 24.h),

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          return CustomPrimaryButton(
                            text: isLoading
                                ? context.tr('sending')
                                : context.tr('send_an_email'),
                            onTap: isLoading
                                ? null
                                : () {
                                    if (authBloc.forgetPasswordFormKey
                                            .currentState
                                            ?.validate() ??
                                        false) {
                                      FocusScope.of(context).unfocus();
                                      authBloc.add(
                                        ForgotPasswordEvent(
                                          email: authBloc.emailController.text
                                              .trim(),
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
    ));
  }
}
