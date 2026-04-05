import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/screens/widgets/custom_add_instructor.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/screens/widgets/custom_card_desktop.dart';
import 'package:lms_admin_instructor/features/instructor/presentation/screens/widgets/custom_nav_bar.dart';
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
            CustomAddInstructor(),
            SizedBox(height: 32.h),
            Row(
              children: [
                CustomCardDesktop(
                  title: "Total Instructors",
                  value: "120",
                  icon: Icons.people_outline,
                  color: Color(0xff3B82F6),
                ),
                SizedBox(width: 20.w),
                CustomCardDesktop(
                  title: "Total Courses",
                  value: "48",
                  icon: Icons.book_outlined,
                  color: Color(0xff16A34A),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: CustomViewer(
                instructorInfo: [
                  "Instructor Name",
                  "BIO",
                  "Join Date",
                  "Email",
                  "Actions",
                ],
                userData: [
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
