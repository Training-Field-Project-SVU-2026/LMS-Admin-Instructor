// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';

class CustomTextFormField extends StatefulWidget {
  final String txt;
  final String hint;
  final double? w;
  final double? h;
  final Color? color;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  const CustomTextFormField({
    Key? key,
    required this.txt,
    required this.hint,
    this.w,
    this.h,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          widget.w ??
          getResponsiveSize(context: context, webSize: 550, mobileSize: 250),
      // height: getResponsiveSize(context: context, webSize: 60, mobileSize: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.txt,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 10.h),
          TextFormField(
            controller: widget.controller,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.primary,
              fontSize: getResponsiveSize(
                context: context,
                webSize: 16,
                mobileSize: 14,
              ),
            ),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, size: 20)
                  : null,

              suffixIcon: widget.suffixIcon != null
                  ? Icon(widget.suffixIcon, size: 20)
                  : null,
              contentPadding: const EdgeInsets.only(
                bottom: 15,
                top: 10,
                left: 16,
                right: 16,
              ),
              labelText: widget.txt,
              labelStyle: TextStyle(
                color: widget.color ?? Colors.grey,
                fontSize: 14,
              ),
              hintText: widget.hint,
              hintStyle: const TextStyle(fontSize: 14),
            ),
            cursorHeight: 24,
            cursorColor: context.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
