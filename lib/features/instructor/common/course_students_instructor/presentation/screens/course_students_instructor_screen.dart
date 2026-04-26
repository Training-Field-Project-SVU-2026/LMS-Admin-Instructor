import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_state.dart';
import 'package:lms_admin_instructor/features/instructor/common/course_students_instructor/domain/entity/course_student_ui_model.dart';

class CourseStudentsInstructorScreen extends StatelessWidget {
  final String slug;
  const CourseStudentsInstructorScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<CourseStatsBloc>()..add(GetCourseStatsEvent(slug: slug)),
      child: Scaffold(
        backgroundColor: context.colorScheme.surfaceContainerHighest,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.isDesktop ? 60.w : 20.w,
            vertical: 40.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 40.h),
              _buildStats(context),
              SizedBox(height: 48.h),
              _buildStudentsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumbs(context),
            SizedBox(height: 12.h),
            BlocBuilder<CourseStatsBloc, CourseStatsState>(
              builder: (context, state) {
                String title = context.tr('analytics');
                if (state is CourseStatsLoaded) {
                  title = state.courseStats.courseTitle;
                }
                return Text(
                  title,
                  style: context.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                );
              },
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => context.pushNamed(
            AppRoutes.courseDetails,
            pathParameters: {'slug': slug},
          ),
          icon: Icon(Icons.edit_outlined, size: 20.sp),
          label: Text(context.tr('edit_course')),
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            foregroundColor: context.colorScheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreadcrumbs(BuildContext context) {
    return Row(
      children: [
        Text(
          context.tr('courses'),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        Icon(
          Icons.chevron_right,
          size: 16.sp,
          color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        Text(
          context.tr('analytics'),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    return BlocBuilder<CourseStatsBloc, CourseStatsState>(
      builder: (context, state) {
        if (state is CourseStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CourseStatsLoaded) {
          final s = state.courseStats;
          return Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: context.tr('total_videos'),
                  value: s.totalVideos.toString(),
                  icon: Icons.video_collection_outlined,
                ),
              ),
              SizedBox(width: 24.w),
              Expanded(
                child: _StatCard(
                  title: context.tr('total_materials'),
                  value: s.totalMaterials.toString(),
                  icon: Icons.description_outlined,
                ),
              ),
              SizedBox(width: 24.w),
              Expanded(
                child: _StatCard(
                  title: context.tr('total_students'),
                  value: s.totalStudents.toString(),
                  icon: Icons.people_outline,
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildStudentsList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.tr('students_enrolled'),
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 300.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 20.sp,
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: context.tr('search_students_hint'),
                              border: InputBorder.none,
                              hintStyle: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.colorScheme.outline.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.tune,
                      size: 20.sp,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32.h),
          _buildTable(context),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    // Mock Data for now
    final mockStudents = [
      CourseStudentUIModel(
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        avatar: '',
        enrollmentDate: 'Oct 24, 2023',
        progress: 0.75,
        slug: '1',
      ),
      CourseStudentUIModel(
        name: 'John Smith',
        email: 'john.smith@example.com',
        avatar: '',
        enrollmentDate: 'Nov 01, 2023',
        progress: 0.45,
        slug: '2',
      ),
      CourseStudentUIModel(
        name: 'Emily Davis',
        email: 'emily.d@example.com',
        avatar: '',
        enrollmentDate: 'Nov 05, 2023',
        progress: 0.90,
        slug: '3',
      ),
      CourseStudentUIModel(
        name: 'Michael Brown',
        email: 'm.brown@example.com',
        avatar: '',
        enrollmentDate: 'Nov 10, 2023',
        progress: 0.12,
        slug: '4',
      ),
      CourseStudentUIModel(
        name: 'Sarah Wilson',
        email: 'sarah.w@example.com',
        avatar: '',
        enrollmentDate: 'Nov 12, 2023',
        progress: 0.60,
        slug: '5',
      ),
    ];

    return Column(
      children: [
        _buildTableHeader(context),
        const Divider(height: 1),
        ...mockStudents.map((s) => _buildStudentRow(context, s)),
        SizedBox(height: 24.h),
        _buildPagination(context),
      ],
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              context.tr('student_name'),
              style: _headerStyle(context),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              context.tr('enrollment_date'),
              style: _headerStyle(context),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(context.tr('progress'), style: _headerStyle(context)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              context.tr('action'),
              style: _headerStyle(context),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle? _headerStyle(BuildContext context) =>
      context.textTheme.labelMedium?.copyWith(
        color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        fontWeight: FontWeight.bold,
      );

  Widget _buildStudentRow(BuildContext context, CourseStudentUIModel student) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: context.colorScheme.primaryContainer,
                  child: Text(
                    student.name[0],
                    style: TextStyle(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      student.email,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              student.enrollmentDate,
              style: context.textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: student.progress,
                      backgroundColor:
                          context.colorScheme.surfaceContainerHighest,
                      color: _getProgressColor(context, student.progress),
                      minHeight: 8.h,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  '${(student.progress * 100).toInt()}%',
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () {},
              child: Text(context.tr('view_profile'), textAlign: TextAlign.end),
            ),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(BuildContext context, double progress) {
    if (progress > 0.8) return Colors.green;
    if (progress > 0.4) return context.colorScheme.primary;
    return Colors.orange;
  }

  Widget _buildPagination(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing 1 to 5 of 156 students',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: null,
              child: Text(context.tr('previous')),
            ),
            SizedBox(width: 8.w),
            OutlinedButton(onPressed: () {}, child: Text(context.tr('next'))),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 24.sp,
                color: context.colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              SizedBox(width: 12.w),
              Text(
                title,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            value,
            style: context.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
