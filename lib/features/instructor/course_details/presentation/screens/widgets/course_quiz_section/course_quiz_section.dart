import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/custom_course_sidebar.dart';

class CourseQuizSection extends StatelessWidget {
  const CourseQuizSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCourseSidebar(
      title: context.tr('quizzes'),
      icon: Icons.quiz,
      color: Colors.purple,
      onManage: () {},
      children: [
        _buildQuizItem(context, "Quiz 1", "10 questions"),
        _buildQuizItem(context, "Quiz 2", "15 questions"),
        _buildQuizItem(context, "Quiz 3", "12 questions"),
        _buildUploadButton(context, "Add Quiz"),
      ],
    );
  }

  Widget _buildQuizItem(BuildContext context, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.list_alt,
                size: 12.sp,
                color: context.colorScheme.outline,
              ),
              SizedBox(width: 4.w),
              Text(subtitle, style: context.textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(BuildContext context, String text) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: context.colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: Text("+ $text", style: context.textTheme.labelMedium),
      ),
    );
  }
}