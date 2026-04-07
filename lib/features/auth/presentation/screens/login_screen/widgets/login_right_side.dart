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
      webSize: 400,
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
      },
      child: Container(
        color: context.colorScheme.surface,
        child: Stack(
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.primary.withValues(alpha: 0.1),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withValues(alpha: 0.1),
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
                  color: context.colorScheme.primary.withValues(alpha: 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.primary.withValues(
                        alpha: 0.08,
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
                    key: authBloc.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.tr('welcome_back'),
                          style: context.textTheme.headlineMedium!.copyWith(
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Good to see you again 👋",
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 48.h),

                        CustomTextFormField(
                          controller: authBloc.emailController,
                          txt: context.tr('email_address'),
                          hint: context.tr('email_hint'),
                          prefixIcon: Icons.alternate_email_rounded,
                          validator: validateEmail,
                          w: formWidth,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          controller: authBloc.passwordController,
                          txt: context.tr('password'),
                          hint: context.tr('password_hint'),
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                          validator: validatePassword,
                          w: formWidth,
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.pushNamed(
                              AppRoutes.forgotPasswordScreen,
                            ),
                            child: Text(
                              context.tr('forgot_password'),
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),

                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;
                            return CustomPrimaryButton(
                              text: "Sign In",
                              onTap: isLoading
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      context.read<AuthBloc>().add(
                                        LoginEvent(),
                                      );
                                    },
                              width: formWidth,
                            );
                          },
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
