import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/widget/custom_card_mobile.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class AdminInstructorMobile extends StatefulWidget {
  const AdminInstructorMobile({super.key});

  @override
  State<AdminInstructorMobile> createState() => _AdminInstructorMobileState();
}

class _AdminInstructorMobileState extends State<AdminInstructorMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Instructors",
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: InkWell(
              onTap: () {},
              child: CustomImage(
                aspectRatio: 1,
                imagePath:
                    "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                width: 40.w,
                height: 40.h,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO:header Page
            Text(
              "Manage Instructors",
              style: context.textTheme.displayMedium?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Create, update and manage instructor profiles and assignments.",
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
            SizedBox(height: 24.h),

            //TODO: cards
            CustomCardMobile(
              colorIcon: context.colorScheme.surface.withValues(alpha: 0.5),
              icon: Icons.person,
              title: "taha zakaria",
              num: "100",
              color1: Color(0xFF0A5C75),
              color2: Color(0xFF117A8B),
              color3: Color(0xFF0A5C75).withValues(alpha: 0.6),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );
  }
}
