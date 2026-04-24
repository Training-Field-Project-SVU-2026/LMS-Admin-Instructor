import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/custom_course_sidebar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class CourseMaterialSection extends StatelessWidget {
  const CourseMaterialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCourseSidebar(
      title: context.tr('course_materials'),
      icon: Icons.folder_outlined,
      color: context.colorScheme.primary,
      onManage: () {},
      children: [
        _buildMaterialItem(context, context.tr('slides_placeholder'), "2.4 MB"),
        SizedBox(height: 16.h),
        _buildUploadButton(context, context.tr('upload_new_material')),
      ],
    );
  }

  Widget _buildMaterialItem(
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
          Icon(
            Icons.keyboard_arrow_down,
            size: 20.sp,
            color: context.colorScheme.onSurface,
          ),
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
                Text(
                  subtitle,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
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

  Widget _buildUploadButton(BuildContext context, String text) {
    return CustomPrimaryButton(
      onTap: () {},
      text: text,
      prefixIcon: Icon(
        Icons.upload_file,
        size: 18.sp,
        color: context.colorScheme.primary,
      ),
      width: double.infinity,
      height: 45.h,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: BorderSide(
          color: context.colorScheme.primary.withValues(alpha: 0.5),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      textStyle: context.textTheme.labelLarge?.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        color: context.colorScheme.primary,
      ),
    );
  }
}
