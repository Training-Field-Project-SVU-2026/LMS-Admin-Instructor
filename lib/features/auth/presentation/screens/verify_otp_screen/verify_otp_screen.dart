import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  late Timer _timer;
  int _secondsRemaining = 120;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formattedTime {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400.w),
          child: Form(
            key: authBloc.otpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.tr('verify_otp_title'),
                  style: context.textTheme.headlineMedium!.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                Text(
                  context.tr('verify_otp_desc'),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 48.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: TextFormField(
                            controller: authBloc.otpControllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: context.colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: context.colorScheme.secondary
                                  .withValues(alpha: 0.03),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: context.colorScheme.secondary
                                      .withValues(alpha: 0.15),
                                  width: 1.5.w,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.r),
                                borderSide: BorderSide(
                                  color: context.colorScheme.secondary,
                                  width: 2.5.w,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 32.h),
                if (_secondsRemaining > 0)
                  Center(
                    child: Text(
                      '${context.tr('resend_code_in')} $_formattedTime',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  Center(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isResending = state is AuthLoading;
                        return TextButton(
                          onPressed: isResending
                              ? null
                              : () {
                                  authBloc.add(
                                    ResendOtpEvent(
                                      email: authBloc.emailController.text
                                          .trim(),
                                    ),
                                  );
                                },
                          child: isResending
                              ? SizedBox(
                                  height: 18.h,
                                  width: 18.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: context.colorScheme.primary,
                                  ),
                                )
                              : Text(
                                  context.tr('resend_code'),
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: context.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 30.h),
                CustomPrimaryButton(
                  text: context.tr('verify_otp_btn'),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    final otpCode = authBloc.getOtpCode();
                    if (otpCode.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.tr('please_enter_full_otp')),
                          backgroundColor: context.colorScheme.error,
                        ),
                      );
                      return;
                    }
                    authBloc.otpController.text = otpCode;
                    context.go(AppRoutes.resetPasswordScreen);
                  },
                  width: 400.w,
                ),
               BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is ResendSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.tr('otp_resent_success')),
                          backgroundColor: context.colorScheme.secondary,
                        ),
                      );
                      setState(() {
                        _startTimer();
                      });
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: context.colorScheme.error,
                        ),
                      );
                    }
                  },
                  child: const SizedBox.shrink(),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
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
    );
  }
}
