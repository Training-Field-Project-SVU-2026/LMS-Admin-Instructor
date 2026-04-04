import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/register_screen/widgets/register_left_side.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/register_screen/widgets/register_right_side.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colorScheme.primary,
              context.colorScheme.primary.withValues(alpha: 0.85),
            ],
          ),
        ),
        child: Row(
          children: [
            if (isTablet(context) || isDesktop(context))
              const Expanded(flex: 1, child: RegisterLeftSide()),
            const Expanded(flex: 1, child: RegisterRightSide()),
          ],
        ),
      ),
    );
  }
}
