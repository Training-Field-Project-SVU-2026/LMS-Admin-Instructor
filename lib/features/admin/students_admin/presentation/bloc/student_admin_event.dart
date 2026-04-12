class StudentAdminEvent {}

class GetStudentsAdminEvent extends StudentAdminEvent {
  final int? page;
  final int? pageSize;
  GetStudentsAdminEvent({this.page, this.pageSize});
}

class DeleteStudentAdminEvent extends StudentAdminEvent {
  final String slug;
  DeleteStudentAdminEvent({required this.slug});
}