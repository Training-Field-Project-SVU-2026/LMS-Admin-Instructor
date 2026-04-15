import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_state.dart';
import 'package:lms_admin_instructor/features/widgets/custom_card_status_info/custom_card_status_info_desktop.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table.dart';
import 'package:lms_admin_instructor/features/widgets/custom_search_app_bar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';

class CoursesInstructorDesktopScreen extends StatefulWidget {
  const CoursesInstructorDesktopScreen({super.key});

  @override
  State<CoursesInstructorDesktopScreen> createState() =>
      _CoursesInstructorDesktopScreenState();
}

class _CoursesInstructorDesktopScreenState
    extends State<CoursesInstructorDesktopScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final instructorSlug =
        sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
    context.read<CoursesInstructorBloc>().add(
      GetCoursesInstructorEvent(instructorSlug: instructorSlug, page: 1),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<CoursesInstructorBloc>().state;
      if (state is CoursesInstructorLoaded && !state.isPaginationLoading) {
        if (state.courseListUIModel.currentPage <
            state.courseListUIModel.totalPages) {
          final instructorSlug =
              sl<CacheHelper>().getDataString(key: ApiKey.slug) ?? '';
          context.read<CoursesInstructorBloc>().add(
            GetCoursesInstructorEvent(
              instructorSlug: instructorSlug,
              page: state.courseListUIModel.currentPage + 1,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary.withValues(alpha: 0.005),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomSearchAppBar(
          hint: context.tr('search_courses_hint'),
          controller: TextEditingController(),
        ),
        toolbarHeight: 70.h,
      ),
      body: Padding(
        padding: EdgeInsets.all(40.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr('all_courses'),
                        style: context.textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        context.tr("courses_screen_subtitle"),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomPrimaryButton(
                  onTap: () {},
                  prefixIcon: const Icon(Icons.add),
                  text: context.tr('create_new_course'),
                  width: 220.w,
                  height: 56.h,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            BlocBuilder<CoursesInstructorBloc, CoursesInstructorState>(
              buildWhen: (previous, current) =>
                  current is CoursesInstructorLoaded,
              builder: (context, state) {
                return Row(
                  children: [
                    CustomCardStatusInfoDesktop(
                      title: context.tr('total_courses'),
                      value: state is CoursesInstructorLoaded
                          ? state.courseListUIModel.totalCourses.toString()
                          : '??',
                      icon: Icons.school_outlined,
                      color: context.colorScheme.primary,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: BlocBuilder<CoursesInstructorBloc, CoursesInstructorState>(
                builder: (context, state) {
                  if (state is CoursesInstructorLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CoursesInstructorError) {
                    return Center(child: Text(state.message));
                  } else if (state is CoursesInstructorLoaded) {
                    return CustomDataTable(
                      headers: [
                        context.tr('course_name'),
                        context.tr('students_enrolled'),
                        context.tr('rating'),
                        context.tr('created_date'),
                      ],
                      columnFlex: const [4, 2, 2, 2],
                      centeredColumns: const [1, 2],
                      data: state.courseListUIModel.courses.map((course) {
                        return course.copyWith(onActionPressed: () {});
                      }).toList(),
                      scrollController: _scrollController,
                      isPaginationLoading: state.isPaginationLoading,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
