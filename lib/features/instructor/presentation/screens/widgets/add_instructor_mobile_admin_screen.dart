import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custom_img.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class AddInstructorMobileAdminScreen extends StatefulWidget {
  const AddInstructorMobileAdminScreen({super.key});

  @override
  State<AddInstructorMobileAdminScreen> createState() =>
      _AddInstructorMobileAdminScreenState();
}

class _AddInstructorMobileAdminScreenState
    extends State<AddInstructorMobileAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Instructors",
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
                width: 45,
                height: 45,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //**************************************??TEXT HEADER??********************************************??
            Text(
              "Add New Instructor",
              style: context.textTheme.displayLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Set up a new instructor account to start managing their courses and tracks.",
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 24.h),

            //**************************************??Discreption??********************************************??
            Container(
              padding: EdgeInsets.all(16.r),
              width: 335.w,
              height: 110.h,
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: context.colorScheme.primary),
                  SizedBox(width: 18.w),

                  Expanded(
                    child: Text(
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      "The instructor will receive an automated email invitation to set their password and complete their profile setup once you save this information.",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            //**************************************??CUSTOM TEXT FORM FILD??********************************************??
            CustomTextFormField(
              h: 50.h,
              w: 340.w,
              txt: "First Name",
              hint: "e.g. Michael",
              controller: TextEditingController(),
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              h: 50.h,
              w: 340.w,
              txt: "Last Name",
              hint: "e.g. Scott",
              controller: TextEditingController(),
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              h: 50.h,
              w: 340.w,
              txt: "Email Address",
              hint: "m.scott@paper.com",
              controller: TextEditingController(),
            ),
            SizedBox(height: 20.h),

            SizedBox(width: 16.w),
            CustomPrimaryButton(
              prefixIcon: Icon(
                size: 20.sp,
                Icons.person_add_alt_1_outlined,
                color: context.colorScheme.surface,
              ),
              textStyle: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.surface,
              ),
              text: "Save Instructor",
              onTap: () {
                Navigator.pop(context);
              },
              width: 342.w,
              height: 64.h,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  "Cancel and Return",
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
