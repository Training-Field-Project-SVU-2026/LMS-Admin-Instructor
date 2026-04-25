import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_details_ui_model.dart';

abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsLoaded extends CourseDetailsState {
  final CourseDetailsUIModel courseDetails;

  CourseDetailsLoaded({required this.courseDetails});
}

class CourseDetailsError extends CourseDetailsState {
  final String message;

  CourseDetailsError({required this.message});
}