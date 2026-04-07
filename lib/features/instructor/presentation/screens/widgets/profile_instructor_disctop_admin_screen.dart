import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';

class ProfileInstructorDisctopAdminScreen extends StatefulWidget {
  const ProfileInstructorDisctopAdminScreen({super.key});

  @override
  State<ProfileInstructorDisctopAdminScreen> createState() =>
      _ProfileInstructorDisctopAdminScreenState();
}

class _ProfileInstructorDisctopAdminScreenState
    extends State<ProfileInstructorDisctopAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          children: [
            //***********************************??Instructor Informations??*****************
            Row(
              children: [
                Container(
                  width: 125.w,
                  height: 125.h,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomImage(
                    imagePath:
                        "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                Column(
                  children: [
                    
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
