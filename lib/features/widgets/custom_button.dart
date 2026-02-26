// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                context: context,
                webSize: 550,
                tabletSize: 400,
                mobileSize: 250,
              ),
          widget.h ??
              getResponsiveSize(
                context: context,
                webSize: 60,
                tabletSize: 55,
                mobileSize: 50,
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
      ),
    );
  }
}
