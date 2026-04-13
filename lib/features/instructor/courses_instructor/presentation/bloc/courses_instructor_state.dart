import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';

abstract class CoursesInstructorState {}

class CoursesInstructorInitial extends CoursesInstructorState {}

class CoursesInstructorLoading extends CoursesInstructorState {}

class CoursesInstructorLoaded extends CoursesInstructorState {
  final CourseInstructorListUIModel courseListUIModel;
  final bool isPaginationLoading;

  CoursesInstructorLoaded({
    required this.courseListUIModel,
    this.isPaginationLoading = false,
  });

  CoursesInstructorLoaded copyWith({
    CourseInstructorListUIModel? courseListUIModel,
    bool? isPaginationLoading,
  }) {
    return CoursesInstructorLoaded(
      courseListUIModel: courseListUIModel ?? this.courseListUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class CoursesInstructorError extends CoursesInstructorState {
  final String message;
  CoursesInstructorError({required this.message});
}
