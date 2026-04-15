import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';

class CourseVideoSection extends StatelessWidget {
  const CourseVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr('course_structure'),
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.tr('expand_all'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                const Text("|"),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.tr('collapse_all'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: context.colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          child: Column(
            children: [
              _buildSectionItem(
                context,
                context.tr('section_all_videos'),
                context.tr('section_subtitle_placeholder'),
              ),
              _buildSubsectionItem(
                context,
                "1",
                context.tr('welcome_course_placeholder'),
                "${context.tr('video_placeholder')} • 02:15",
              ),
              _buildSubsectionItem(
                context,
                "2",
                context.tr('why_patterns_placeholder'),
                "${context.tr('video_placeholder')} • 05:30",
              ),
              _buildSubsectionItem(
                context,
                "3",
                context.tr('setup_env_placeholder'),
                "${context.tr('video_placeholder')} • 07:45",
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildAddNewButton(
          context,
          context.tr('add_new_video'),
          Icons.add_circle_outline,
        ),
      ],
    );
  }

  Widget _buildSectionItem(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.keyboard_arrow_down, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subtitle, style: context.textTheme.labelSmall),
              ],
            ),
          ),
          Icon(
            Icons.edit_outlined,
            size: 18.sp,
            color: context.colorScheme.outline,
          ),
          SizedBox(width: 12.w),
          Icon(
            Icons.delete_outline,
            size: 18.sp,
            color: context.colorScheme.outline,
          ),
        ],
      ),
    );
  }

  Widget _buildSubsectionItem(
    BuildContext context,
    String number,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: TextStyle(
                color: context.colorScheme.primary,
                fontSize: 12.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.video_library_outlined,
                      size: 12.sp,
                      color: context.colorScheme.outline,
                    ),
                    SizedBox(width: 4.w),
                    Text(subtitle, style: context.textTheme.labelSmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewButton(BuildContext context, String text, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 20.sp),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: context.colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }
}
