import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
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
    final formWidth = getResponsiveSize(
      context: context,
      webSize: 450,
      mobileSize: 350,
    );

    final authBloc = context.read<AuthBloc>();

    return Center(
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
                    return SizedBox(
                      width: getResponsiveSize(
                        context: context,
                        webSize: 55,
                        mobileSize: 45,
                      ),
                      height: getResponsiveSize(
                        context: context,
                        webSize: 65,
                        mobileSize: 55,
                      ),
                      child: TextFormField(
                        controller: authBloc.otpControllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: context.colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: context.colorScheme.primary,
                              width: 2,
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
                    child: TextButton(
                      onPressed: () {
                        authBloc.add(
                          ForgotPasswordEvent(email: widget.email),
                        );
                        setState(() {
                          _startTimer();
                        });
                      },
                      child: Text(
                        context.tr('resend_code'),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 48.h),

                CustomPrimaryButton(
                  text: context.tr('verify_otp_btn'),
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    context.go(AppRoutes.resetPasswordScreen);
                  },
                  width: formWidth,
                ),

                SizedBox(height: 24.h),

                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      context.go(AppRoutes.forgotPasswordScreen);
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
    );
  }
}
