import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class CustomAddInstructor extends StatefulWidget {
  const CustomAddInstructor({super.key});

  @override
  State<CustomAddInstructor> createState() => _CustomAddInstructorState();
}

class _CustomAddInstructorState extends State<CustomAddInstructor> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage Instructors",
              style: context.textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            Text(
              "Create, update and manage instructor profiles and assignments.",
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        Spacer(),
        CustomPrimaryButton(
          prefixIcon: Icon(Icons.add),
          text: "Add Instructor",
          onTap: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ],
    );
  }
}
