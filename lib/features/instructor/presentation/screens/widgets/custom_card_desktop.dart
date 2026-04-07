import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomCardDesktop extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  const CustomCardDesktop({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  State<CustomCardDesktop> createState() => _CustomCardDesktopState();
}

class _CustomCardDesktopState extends State<CustomCardDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      width: 300.w,
      height: 115.h,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 1,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.value,
                style: context.textTheme.titleLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(widget.icon, color: widget.color),
          ),
        ],
      ),
    );
  }
}

// Color(0xff3B82F6)
