import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/widgets/custom_search_app_bar.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_info_card.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_video_section/course_video_section.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_material_section/course_material_section.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/course_quiz_section/course_quiz_section.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_details_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_details_bloc/course_details_state.dart';

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
      body: BlocProvider(
        create: (context) =>
            sl<CourseDetailsBloc>()..add(GetCourseDetailsEvent(slug: slug)),
        child: BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
          builder: (context, state) {
            if (state is CourseDetailsLoading ||
                state is CourseDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CourseDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is CourseDetailsLoaded) {
              return _buildBody(context, state.courseDetails);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CourseDetailsUIModel course) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.isDesktop ? 60.w : 16.w,
        vertical: 32.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumbs(context, course.title),
          SizedBox(height: 24.h),
          CourseInfoCard(course: course),
          SizedBox(height: 32.h),
          if (context.isDesktop)
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
                      CourseQuizSection(courseSlug: slug),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                const CourseVideoSection(),
                SizedBox(height: 32.h),
                const CourseMaterialSection(),
                SizedBox(height: 32.h),
                CourseQuizSection(courseSlug: slug),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs(BuildContext context, String courseTitle) {
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
          courseTitle.isNotEmpty
              ? courseTitle
              : context.tr('course_title_placeholder'),
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
