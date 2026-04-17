import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_state.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_instructor_information_disktop.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/stats_card_widget%20.dart';

import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/screens/widgets/custom_course_card_disktop.dart';

class ProfileInstructorDisctopAdminScreen extends StatefulWidget {
  final String slug;
  const ProfileInstructorDisctopAdminScreen({super.key, required this.slug});

  @override
  State<ProfileInstructorDisctopAdminScreen> createState() =>
      _ProfileInstructorDisctopAdminScreenState();
}

class _ProfileInstructorDisctopAdminScreenState
    extends State<ProfileInstructorDisctopAdminScreen> {
  @override
  void initState() {
    context.read<InstructorAdminBloc>().add(
      GetInstructorBySlugEvent(slug: widget.slug),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Instructor")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //***********************************??Instructor Informations??*****************
            BlocBuilder<InstructorAdminBloc, InstructorAdminState>(
              builder: (context, state) {
                if (state is InstructorDetailsLoading) {
                  return SizedBox(
                    height: 150.h,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is InstructorDetailsError) {
                  log(state.message);
                  return Center(child: Text(state.message));
                }
                if (state is InstructorDetailsLoaded) {
                  final instructor = state.instructorDetailsUiModel.data;
                  return CustomInstructorInformationDisktop(
                    name: "${instructor.first_name} ${instructor.last_name}",
                    description: instructor.description ?? "",
                    image: instructor.image ?? "",
                  );
                }
                return const SizedBox.shrink();
              },
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

            SizedBox(height: 48.h),

            //***********************************??Assigned Courses??*****************
            Text(
              "Assigned Courses",
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 24.h),

            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 1200
                    ? 3
                    : (constraints.maxWidth > 800 ? 2 : 1);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24.w,
                    mainAxisSpacing: 24.h,
                    childAspectRatio: 1.4,
                  ),
                  itemCount: 4, // Placeholder count
                  itemBuilder: (context, index) {
                    return CustomCourseCardDisktop(
                      title: "Ultimate Flutter & Dart Bootcamp 2026",
                      description:
                          "Master Flutter and Dart by building 20+ real-world apps with clean architecture and advanced state management.",
                      image:
                          "https://i.pinimg.com/736x/2e/76/31/2e763110981d9269aeb96ec1ddae93cf.jpg",
                      totalStudents: 1250,
                      rating: 4.9,
                      duration: "45h 20m",
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
