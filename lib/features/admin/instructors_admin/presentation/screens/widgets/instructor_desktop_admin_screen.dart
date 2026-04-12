import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/widgets/custom_add_row/custom_add_row_widget.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_desktop.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_nav_bar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_viewer.dart';
import 'package:lms_admin_instructor/features/widgets/instructor.dart';

class InstructorDesktopAdminScreen extends StatefulWidget {
  const InstructorDesktopAdminScreen({super.key});

  @override
  State<InstructorDesktopAdminScreen> createState() =>
      _InstructorDesktopAdminScreenState();
}

class _InstructorDesktopAdminScreenState
    extends State<InstructorDesktopAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.005),
      //**************************************??AppBar??********************************************??
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomNavBar(),
        toolbarHeight: 70.h,
      ),
      body: Padding(
        padding: EdgeInsets.all(40.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAddRowWidget(
              title: context.tr('manage_instructors'),
              description: context.tr(
                'create_update_manage_instructor_profiles_assignments',
              ),
              buttonText: context.tr('add_instructor'),
              icon: Icons.people_outline,
              onTap: () {
                context.push(AppRoutes.addInstructorAdminScreen);
              },
            ),
            SizedBox(height: 32.h),
            //**************************************??Details Cards??********************************************??
            Row(
              children: [
                CustomCardStatusInfoDesktop(
                  title: context.tr('total_instructors'),
                  value: "120",
                  icon: Icons.people_outline,
                  color: Color(0xff3B82F6),
                ),
                SizedBox(width: 20.w),
                CustomCardStatusInfoDesktop(
                  title: context.tr('total_courses'),
                  value: "48",
                  icon: Icons.book_outlined,
                  color: Color(0xff16A34A),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            //**************************************??show all instructors??********************************************??
            Expanded(
              child: CustomViewer(
                instructorInfo: [
                  context.tr('instructor_name_column'),
                  context.tr('bio_column'),
                  context.tr('join_date_column'),
                  context.tr('email_column'),
                  context.tr('actions_column'),
                ],
                userData: [
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {
                      context.push(AppRoutes.profileInstructorAdminScreen);
                    },
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
                  ),
                  Instructor(
                    name: "John Doe",
                    bio: "PhD in Computer Science with 10 years of exp…",
                    date: "2022-01-01",
                    email: "[EMAIL_ADDRESS]",
                    action: () {},
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
