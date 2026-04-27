import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/domain/entity/course_student_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_students_instructor/presentation/bloc/course_students_state.dart';

class CourseStudentsTable extends StatelessWidget {
  const CourseStudentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.r),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.secondary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilterHeader(context),
          SizedBox(height: 32.h),
          _buildTableHeader(context),
          const Divider(height: 1),
          BlocBuilder<CourseStudentsBloc, CourseStudentsState>(
            builder: (context, state) {
              if (state is CourseStudentsLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 48),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CourseStudentsError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Text(state.message),
                  ),
                );
              } else if (state is CourseStudentsLoaded) {
                final students = state.studentsListUIModel.students;
                if (students.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Text("No students enrolled yet"),
                    ),
                  );
                }
                return Column(
                  children: [
                    ...students.map((s) => _buildStudentRow(context, s)),
                    if (state.isPaginationLoading)
                      const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterHeader(BuildContext context) {
    return Row(
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
                color: context.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 20.sp,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.5),
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
                  color: context.colorScheme.outline.withValues(alpha: 0.2),
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

  Widget _buildStudentRow(
    BuildContext context,
    CourseStudentItemUIModel student,
  ) {
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
}
