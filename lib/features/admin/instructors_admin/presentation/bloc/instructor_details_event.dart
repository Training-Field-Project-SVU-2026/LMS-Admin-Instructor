class InstructorDetailsEvent {}

class GetInstructorCoursesEvent extends InstructorDetailsEvent {
  final String slug;
  final int? page;
  final int? pageSize;

  GetInstructorCoursesEvent({required this.slug, this.page, this.pageSize});
}
