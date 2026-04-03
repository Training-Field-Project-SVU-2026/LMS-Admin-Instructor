import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? iconPadding;
  final double? iconSize;
  final TextStyle? textStyle;
  final ButtonStyle?
  style; 
  final Color?
  color; 

  const CustomPrimaryButton({
    super.key,
    required this.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.width,
    this.height,
    this.iconPadding,
    this.iconSize,
    this.textStyle,
    this.style,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultColor =
        textStyle?.color ??
        style?.foregroundColor?.resolve({}) ??
        context.colorScheme.onPrimary;

    return SizedBox(
      width: width?.w ?? 278.w,
      height: height?.h ?? 50.h,
      child: ElevatedButton(
        onPressed: onTap,

        style:
            style, 
        child: IconTheme(
          data: IconThemeData(color: defaultColor, size: iconSize?.w ?? 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: iconPadding?.w ?? 8.w),
              ],

              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  style: (textStyle ?? context.textTheme.labelLarge)?.copyWith(
                    color: defaultColor,
                  ),
                ),
              ),

              
              if (suffixIcon != null) ...[
                SizedBox(width: iconPadding?.w ?? 8.w),
                suffixIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}