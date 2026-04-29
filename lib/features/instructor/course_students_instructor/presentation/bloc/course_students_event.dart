abstract class CourseStudentsEvent {
  const CourseStudentsEvent();
}

class GetCourseStudentsEvent extends CourseStudentsEvent {
  final String slug;
  final int? page;
  final int? pageSize;

  GetCourseStudentsEvent({
    required this.slug,
    this.page,
    this.pageSize,
  });
}
