// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/utils/get_restponsive_size.dart';

class CustomButton extends StatefulWidget {
  final String txt;
  final Function() onPressed;
  final double? w;
  final double? h;
  final Color? color;
  CustomButton({
    Key? key,
    required this.txt,
    required this.onPressed,
    this.w,
    this.h,
    this.color,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        fixedSize: Size(
          widget.w ??
              getResponsiveSize(
                webSize: 550.w,
                mobileSize: 200.w,
                width: MediaQuery.of(context).size.width,
              ),
          widget.h ??
              getResponsiveSize(
                webSize: 60.h,
                mobileSize: 50.h,
                width: MediaQuery.of(context).size.width,
              ),
        ),
        backgroundColor: widget.color ?? context.colorScheme.primary,
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.txt,
        style: context.textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        // style: TextStyle(
        //   fontFamily: "Inter",
        //   fontSize: 24,
        //   fontWeight: FontWeight.bold,
        //   color: Colors.white,
        // ),
      ),
    );
  }
}
