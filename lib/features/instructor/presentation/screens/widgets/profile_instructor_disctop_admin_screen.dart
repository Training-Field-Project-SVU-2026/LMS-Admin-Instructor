import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //***********************************??Instructor Informations??*****************
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomImage(
                    imagePath:
                        "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(width: 24.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Instructor /",
                            style: context.textTheme.labelLarge?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: " Details",
                            style: context.textTheme.labelLarge?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("Eng. Taha", style: context.textTheme.headlineLarge),

                    Row(
                      children: [
                        SizedBox(
                          width: 300.w, // عرض محدد للنص
                          child: Text(
                            "Senior Data Science InstructorSenior Data Science InstructorSenior Data Science InstructorSenior Data Science InstructorSenior Data Science InstructorSenior Data Science InstructorSenior Data Science InstructorSenior Data Science Instructor",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 400.w),
                        SizedBox(
                          width: 200.w,
                          // height: 55.h,
                          child: CustomPrimaryButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              backgroundColor: context.colorScheme.error,
                            ),
                            onTap: () {},
                            text: "Delete Account",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
