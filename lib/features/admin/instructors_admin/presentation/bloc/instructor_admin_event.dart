class InstructorAdminEvent {}

class GetInstructorAdminEvent extends InstructorAdminEvent {
  final int? page;
  final int? pageSize;
  GetInstructorAdminEvent({this.page, this.pageSize});
}

class AddInstructorEvent extends InstructorAdminEvent {
  final String first_name;
  final String last_name;
  final String email;

  AddInstructorEvent({
    required this.first_name,
    required this.last_name,
    required this.email,
  });
}
