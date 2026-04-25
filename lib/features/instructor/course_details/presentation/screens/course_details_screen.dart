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
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_stats_bloc/course_stats_event.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String slug;
  const CourseDetailsScreen({super.key, required this.slug});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool _wasUpdated = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<CourseDetailsBloc>()
                ..add(GetCourseDetailsEvent(slug: widget.slug)),
        ),
        BlocProvider(
          create: (context) =>
              sl<CourseStatsBloc>()
                ..add(GetCourseStatsEvent(slug: widget.slug)),
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          context.pop(_wasUpdated);
        },
        child: BlocListener<CourseDetailsBloc, CourseDetailsState>(
          listener: (context, state) {
            if (state is UpdateCourseSuccess) {
              _wasUpdated = true;
            }
          },
          child: Scaffold(
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: CustomSearchAppBar(
                hint: context.tr('search_courses_hint'),
                controller: TextEditingController(),
              ),
              toolbarHeight: 70.h,
            ),
            body: BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
              buildWhen: (previous, current) =>
                  current is CourseDetailsLoaded ||
                  current is CourseDetailsError ||
                  (current is CourseDetailsLoading &&
                      previous is CourseDetailsInitial),
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
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CourseDetailsUIModel course) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.isDesktop ? 80.w : 20.w,
        vertical: 40.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBreadcrumbs(context, course.title),
          SizedBox(height: 32.h),
          CourseInfoCard(course: course),
          SizedBox(height: 40.h),
          if (context.isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 2, child: CourseVideoSection()),
                SizedBox(width: 40.w),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const CourseMaterialSection(),
                      SizedBox(height: 32.h),
                      CourseQuizSection(courseSlug: widget.slug),
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
                CourseQuizSection(courseSlug: widget.slug),
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
          onTap: () => context.pop(_wasUpdated),
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
