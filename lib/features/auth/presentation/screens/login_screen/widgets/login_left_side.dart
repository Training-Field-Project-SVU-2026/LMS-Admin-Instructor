import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';

class LoginLeftSide extends StatelessWidget {
  const LoginLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 400.w,
            height: 400.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  context.colorScheme.secondary.withValues(alpha: 0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          left: -150,
          child: Container(
            width: 500.w,
            height: 500.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  context.colorScheme.onPrimary.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsiveSize(
                context: context,
                webSize: 80,
                mobileSize: 24,
              ),
              vertical: 40,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: context.colorScheme.onPrimary.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.colorScheme.onPrimary.withValues(
                              alpha: 0.2,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.commit_outlined,
                          color: context.colorScheme.secondary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          context.tr('commit_ma3ana'),
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            fontSize: getResponsiveSize(
                              context: context,
                              webSize: 28,
                              mobileSize: 20,
                            ),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  Expanded(
                    flex: 6,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 180.w,
                          height: 180.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: context.colorScheme.secondary.withValues(
                                  alpha: 0.25,
                                ),
                                blurRadius: 100,
                                spreadRadius: 40,
                              ),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/login.svg',
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  RichText(
                    text: TextSpan(
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        fontSize: getResponsiveSize(
                          context: context,
                          webSize: 48,
                          mobileSize: 28,
                        ),
                      ),
                      children: [
                        TextSpan(text: context.tr('commit_today')),
                        TextSpan(
                          text: context.tr('build_your_future'),
                          style: TextStyle(
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    context.tr('join_learners_desc'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onPrimary.withValues(
                        alpha: 0.75,
                      ),
                      height: 1.6.h,
                      fontSize: getResponsiveSize(
                        context: context,
                        webSize: 18,
                        mobileSize: 14,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
