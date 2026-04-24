import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_state.dart';
import 'package:lms_admin_instructor/features/widgets/error_feedback_widget.dart';
import 'package:lms_admin_instructor/features/widgets/loading_indicator_widget.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/screens/widgets/custom_course_sidebar.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';

class CourseQuizSection extends StatefulWidget {
  final String courseSlug;
  const CourseQuizSection({super.key, required this.courseSlug});

  @override
  State<CourseQuizSection> createState() => _CourseQuizSectionState();
}

class _CourseQuizSectionState extends State<CourseQuizSection> {
  @override
  void initState() {
    super.initState();
    context.read<CourseQuizBloc>().add(
      GetQuizzesForCourseEvent(courseSlug: widget.courseSlug),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseQuizBloc, CourseQuizState>(
      builder: (context, state) {
        if (state is CourseQuizLoading) {
          return const LoadingIndicatorWidget();
        }

        if (state is CourseQuizError) {
          return ErrorFeedbackWidget(
            errorMessage: state.message,
            onRetry: () {
              context.read<CourseQuizBloc>().add(
                GetQuizzesForCourseEvent(courseSlug: widget.courseSlug),
              );
            },
          );
        }

        if (state is CourseQuizLoaded) {
          final quizzes = state.uiModel?.quizzes ?? [];
          final hasMore =
              (state.uiModel?.currentPage ?? 1) <
              (state.uiModel?.totalPages ?? 1);

          return CustomCourseSidebar(
            title: context.tr('quizzes'),
            icon: Icons.quiz,
            color: Colors.purple,
            children: [
              ...quizzes.map(
                (quiz) => _buildQuizItem(
                  context,
                  quiz.quizName,
                  "${quiz.totalMark} ${context.tr('marks')}",
                ),
              ),
              if (hasMore)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Center(
                    child: TextButton(
                      onPressed: state.isPaginationLoading
                          ? null
                          : () {
                              context.read<CourseQuizBloc>().add(
                                GetQuizzesForCourseEvent(
                                  courseSlug: widget.courseSlug,
                                  page: (state.uiModel?.currentPage ?? 1) + 1,
                                ),
                              );
                            },
                      child: state.isPaginationLoading
                          ? SizedBox(
                              height: 16.h,
                              width: 16.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                                color: context.colorScheme.primary,
                              ),
                            )
                          : Text(
                              context.tr("show_more"),
                              style: context.textTheme.labelMedium?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              _buildUploadButton(context, context.tr("add_quiz")),
            ],
          );
        }

        return const SizedBox.shrink();
      },
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
    return CustomPrimaryButton(
      onTap: () {
        context.pushNamed(
          AppRoutes.addQuizScreen,
          pathParameters: {"slug": widget.courseSlug},
        );
      },
      text: text,
      prefixIcon: Icon(
        Icons.add,
        size: 18.sp,
        color: context.colorScheme.primary,
      ),
      width: double.infinity,
      height: 45.h,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: BorderSide(color: context.colorScheme.outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      textStyle: context.textTheme.labelMedium?.copyWith(
        color: context.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
