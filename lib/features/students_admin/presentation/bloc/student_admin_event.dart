class StudentAdminEvent {}

class GetStudentsAdminEvent extends StudentAdminEvent {
  final int? page;
  final int? pageSize;
  GetStudentsAdminEvent({this.page, this.pageSize});
}