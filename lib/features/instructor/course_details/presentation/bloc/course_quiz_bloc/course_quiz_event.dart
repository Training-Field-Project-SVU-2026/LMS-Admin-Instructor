abstract class CourseQuizEvent {}

class GetQuizzesForCourseEvent extends CourseQuizEvent {
  final String courseSlug;
  final int? page;
  final int? pageSize;

  GetQuizzesForCourseEvent({
    required this.courseSlug,
    this.page,
    this.pageSize,
  });
}