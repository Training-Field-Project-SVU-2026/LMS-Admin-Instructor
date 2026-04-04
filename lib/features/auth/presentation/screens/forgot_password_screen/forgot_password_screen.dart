import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/auth/presentation/screens/forgot_password_screen/widgets/forgot_password_card.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Immersive Full Screen Gradient Background
          Container(
            width: double.infinity,
            height: double.infinity,
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
          ),

          // Massive Abstract Glow Orbs
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 500,
              height: 500,
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
            bottom: -200,
            right: -100,
            child: Container(
              width: 600,
              height: 600,
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

          // Central Glassmorphic Card Layout
          const Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
                  child: ForgotPasswordCard(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
