import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class CourseSidebar extends StatelessWidget {
  const CourseSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSidebarCard(
          context,
          context.tr('course_materials'),
          Icons.folder_outlined,
          Colors.orange,
          () {},
          child: Column(
            children: [
              _buildMaterialItem(
                context,
                context.tr('slides_placeholder'),
                "2.4 MB",
              ),
              SizedBox(height: 16.h),
              _buildUploadButton(context, context.tr('upload_new_material')),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        _buildSidebarCard(
          context,
          context.tr('quizzes'),
          Icons.assignment_outlined,
          Colors.purple,
          () {},
          child: Column(
            children: [
              _buildQuizItem(
                context,
                context.tr('intro_assessment_placeholder'),
                context.tr('intro_assessment_subtitle'),
              ),
              _buildQuizItem(
                context,
                context.tr('react_state_quiz_placeholder'),
                context.tr('react_state_quiz_subtitle'),
              ),
              SizedBox(height: 16.h),
              CustomPrimaryButton(
                onTap: () {},
                text: context.tr('create_new_quiz'),
                prefixIcon: Icon(Icons.add, size: 18.sp, color: Colors.white),
                width: double.infinity,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        _buildContentTipsCard(context),
      ],
    );
  }

  Widget _buildSidebarCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onManage, {
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Icon(icon, size: 20.sp, color: color),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onManage,
                  child: Text(
                    context.tr('manage'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: context.colorScheme.outline.withValues(alpha: 0.3),
          ),
          Padding(padding: EdgeInsets.all(16.r), child: child),
        ],
      ),
    );
  }

  Widget _buildMaterialItem(BuildContext context, String name, String size) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: context.colorScheme.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            context.tr('pdf'),
            style: TextStyle(
              color: context.colorScheme.error,
              fontSize: 8.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(size, style: context.textTheme.labelSmall),
            ],
          ),
        ),
      ],
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

  Widget _buildContentTipsCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                context.tr('content_tips'),
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            context.tr('tips_placeholder'),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.primary.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
