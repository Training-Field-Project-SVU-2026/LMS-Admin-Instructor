import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';

class LoginLeftSide extends StatelessWidget {
  const LoginLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Premium Glowing Orbs Background
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 400,
            height: 400,
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
            width: 500,
            height: 500,
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

        // Content
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getResponsiveSize(
                context: context,
                webSize: 80,
                mobileSize: 24,
              ),
              vertical:
                  40, // Locked vertical padding so texts don't crush the SVG height
            ),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Brand Logo Area
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
                          'Commit Ma3ana',
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

                  // Main Hero Illustration with Glow and Float
                  Expanded(
                    flex: 6,
                    child: FloatingIllustration(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Fancy Glowing Aura behind Illustration
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: context.colorScheme.secondary
                                      .withValues(alpha: 0.25),
                                  blurRadius: 100,
                                  spreadRadius: 40,
                                ),
                              ],
                            ),
                          ),
                          // The User's Illustration
                          SvgPicture.asset(
                            'assets/icons/login.svg',
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Premium Typography
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
                        const TextSpan(text: 'Commit today.\n'),
                        TextSpan(
                          text: 'Build your future.',
                          style: TextStyle(
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Join thousands of learners building consistency and\ngrowing their programming skills — one commit at a time.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onPrimary.withValues(
                        alpha: 0.75,
                      ),
                      height: 1.6,
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
        ),
      ],
    );
  }
}

// Private widget for elegant floating animation
class FloatingIllustration extends StatefulWidget {
  final Widget child;
  const FloatingIllustration({super.key, required this.child});

  @override
  State<FloatingIllustration> createState() => _FloatingIllustrationState();
}

class _FloatingIllustrationState extends State<FloatingIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2500),
  )..repeat(reverse: true);

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(0, -0.05),
    end: const Offset(0, 0.05),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}
