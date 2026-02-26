// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_restponsive_size.dart';

class CustomTextFormField extends StatefulWidget {
  final String txt;
  final String hint;
  final double? w;
  final double? h;
  final Color? color;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  CustomTextFormField({
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
          getResponsiveSize(
            context: context,
            webSize: 550,
            tabletSize: 400,
            mobileSize: 250,
          ),
      height: getResponsiveSize(
        context: context,
        webSize: 60,
        tabletSize: 55,
        mobileSize: 50,
      ),
      child: TextFormField(
        controller: widget.controller,
        style: context.textTheme.labelMedium?.copyWith(
          color: context.colorScheme.primary,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon)
              : null,

          suffixIcon: widget.suffixIcon != null
              ? Icon(widget.suffixIcon)
              : null,
          contentPadding: EdgeInsets.only(
            bottom: 15.h,
            top: 10.h,
            left: 10.w,
            right: 10.w,
          ),
          labelText: widget.txt,
          labelStyle: TextStyle(color: widget.color ?? Colors.grey),
          hintText: widget.hint,
          hintStyle: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.primary,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        cursorHeight: 30.h,
        cursorColor: context.colorScheme.primary,
      ),
    );
  }
}
