import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_instructor_information_disktop.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/stats_card_widget%20.dart';

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
      appBar: AppBar(title: Text("Profile Instructor")),
      body: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //***********************************??Instructor Informations??*****************
            CustomInstructorInformationDisktop(
              name: "Eng. Taha",
              description: "Senior Data Science Instructor",
              image:
                  "https://i.pinimg.com/474x/be/24/f1/be24f1ad82c82e78997c80ff0f8d6a53.jpg",
            ),
            SizedBox(height: 32.h),

            //***********************************??Instructor Stats??*****************
            Row(
              children: [
                StatsCardWidget(
                  backGroundIconColor: context.colorScheme.primary.withValues(
                    alpha: 0.1,
                  ),
                  title: "Total Students",
                  value: "14,285",
                  icon: Icons.people_alt_rounded,
                  iconColor: context.colorScheme.primary,
                ),
                SizedBox(width: 24.w),
                StatsCardWidget(
                  title: "Avg. Total Course Rating",
                  value: "4.9",
                  icon: Icons.star_border_outlined,
                  iconColor: Colors.amber,
                  backGroundIconColor: Colors.amber.withValues(alpha: 0.1),
                  subtitle: "/5",
                  footerText: "Based on 3,420 reviews",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
