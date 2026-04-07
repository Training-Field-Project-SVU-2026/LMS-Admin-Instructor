import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/login_screen/widgets/login_left_side.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/login_screen/widgets/login_right_side.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Row(
        children: [
          if (context.isDesktop)
            const Expanded(flex: 1, child: LoginLeftSide()),
          const Expanded(flex: 1, child: LoginRightSide()),
        ],
      ),
    );
  }
}
