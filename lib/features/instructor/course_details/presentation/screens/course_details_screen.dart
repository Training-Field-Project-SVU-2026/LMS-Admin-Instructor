import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_search_app_bar.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_info_card.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_video_section/course_video_section.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/custom_course_sidebar.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_material_section/course_material_section.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_quiz_section/course_quiz_section.dart';

class CourseDetailsScreen extends StatelessWidget {
  final String slug;
  const CourseDetailsScreen({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomSearchAppBar(
          hint: context.tr('search_courses_hint'),
          controller: TextEditingController(),
        ),
        toolbarHeight: 70.h,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.isDesktop ? 60.w : 16.w,
          vertical: 32.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreadcrumbs(context),
            SizedBox(height: 24.h),
            const CourseInfoCard(),
            SizedBox(height: 32.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 2, child: CourseVideoSection()),
                SizedBox(width: 32.w),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const CourseMaterialSection(),
                      SizedBox(height: 32.h),
                      const CourseQuizSection(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreadcrumbs(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Text(
            context.tr('courses'),
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
        Icon(
          Icons.chevron_right,
          size: 16.sp,
          color: context.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        Text(
          context.tr('course_title_placeholder'),
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
