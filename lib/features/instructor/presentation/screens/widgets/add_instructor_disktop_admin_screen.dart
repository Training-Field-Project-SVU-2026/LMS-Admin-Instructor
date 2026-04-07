import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class AddInstructorDisktopAdminScreen extends StatelessWidget {
  const AddInstructorDisktopAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Back to Instructors",
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.6),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 208.w, vertical: 128.h),
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
            SizedBox(height: 40.h),
            //**************************************??CUSTOM TEXT FORM FILD??********************************************??
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.4),
                    blurRadius: 10.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(32.r),
                    width: 770.w,
                    height: 380.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextFormField(
                              h: 50.h,
                              w: 340.w,
                              txt: "First Name",
                              hint: "e.g. Michael",
                              controller: TextEditingController(),
                            ),
                            SizedBox(width: 24.w),
                            CustomTextFormField(
                              h: 50.h,
                              w: 340.w,
                              txt: "Last Name",
                              hint: "e.g. Scott ",
                              controller: TextEditingController(),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          h: 60.h,
                          w: 700.w,
                          txt: "Email Address",
                          hint: "m.scott@paper.com",
                          controller: TextEditingController(),
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(height: 24.h),

                        Container(
                          padding: EdgeInsets.all(18.r),
                          width: 700.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: context.colorScheme.primary,
                              ),
                              SizedBox(width: 18.w),

                              Expanded(
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  "The instructor will receive an automated email invitation to set their password and complete their profile setup once you save this information.",
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        color: context.colorScheme.onSurface
                                            .withValues(alpha: 0.8),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //**************************************??BUTTONS??********************************************??
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.r,
                      vertical: 16.r,
                    ),
                    width: 770.w,
                    height: 73.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            "Cancel",
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        CustomPrimaryButton(
                          suffixIcon: Icon(
                            size: 15.sp,
                            Icons.person_add_alt_1_outlined,
                            color: context.colorScheme.surface,
                          ),
                          textStyle: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.surface,
                          ),
                          text: "Add Instructor",
                          onTap: () {
                            Navigator.pop(context);
                          },
                          width: 171.w,
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
