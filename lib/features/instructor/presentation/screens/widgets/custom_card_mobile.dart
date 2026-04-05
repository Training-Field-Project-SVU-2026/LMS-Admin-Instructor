import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomCardMobile extends StatefulWidget {
  final String title;
  final String num;
  final Color color1;
  final Color color2;
  final Color color3;
  final Color colorIcon;
  final IconData icon;

  const CustomCardMobile({
    super.key,
    required this.title,
    required this.num,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.colorIcon,
    required this.icon,
  });

  @override
  State<CustomCardMobile> createState() => _CustomCardMobileState();
}

class _CustomCardMobileState extends State<CustomCardMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      width: 163.w,
      height: 133.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [widget.color1, widget.color2, widget.color3],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 1,
            offset: Offset(3, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(widget.icon, color: widget.colorIcon.withValues(alpha: 0.5)),
          Spacer(),
          Text(
            widget.num,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
          ),

          Spacer(),
          Text(
            widget.title,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
