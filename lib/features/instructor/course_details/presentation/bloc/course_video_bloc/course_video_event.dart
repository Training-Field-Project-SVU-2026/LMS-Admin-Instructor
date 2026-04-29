abstract class CourseVideoEvent {}

class GetCourseVideosEvent extends CourseVideoEvent {
  final String courseSlug;

  GetCourseVideosEvent({required this.courseSlug});
}
