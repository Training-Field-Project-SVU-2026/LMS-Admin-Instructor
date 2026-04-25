abstract class CourseDetailsEvent {}

class GetCourseDetailsEvent extends CourseDetailsEvent {
  final String slug;

  GetCourseDetailsEvent({required this.slug});
}