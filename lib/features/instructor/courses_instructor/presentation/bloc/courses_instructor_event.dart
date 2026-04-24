class CoursesInstructorEvent {}

class GetCoursesInstructorEvent extends CoursesInstructorEvent {
  final String instructorSlug;
  final int? page;
  final int? pageSize;
  GetCoursesInstructorEvent({
    required this.instructorSlug,
    this.page,
    this.pageSize,
  });
}

class DeleteCourseInstructorEvent extends CoursesInstructorEvent {
  final String slug;
  DeleteCourseInstructorEvent({required this.slug});
}