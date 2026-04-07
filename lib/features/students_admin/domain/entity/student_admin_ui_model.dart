class StudentAdminUIModel {
  final List<StudentItemUIModel> students;
  final int totalEnrollments;
  final int totalPages;
  final int currentPage;

  StudentAdminUIModel({
    required this.students,
    required this.totalEnrollments,
    required this.totalPages,
    required this.currentPage,
  });

  StudentAdminUIModel copyWith({
    List<StudentItemUIModel>? students,
    int? totalEnrollments,
    int? totalPages,
    int? currentPage,
  }) {
    return StudentAdminUIModel(
      students: students ?? this.students,
      totalEnrollments: totalEnrollments ?? this.totalEnrollments,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class StudentItemUIModel {
  final String studentName;
  final String email;
  final bool isActive;
  final int enrollmentsCount;
  final String? image;

  StudentItemUIModel({
    required this.studentName,
    required this.email,
    required this.isActive,
    required this.enrollmentsCount,
    this.image,
  });
}
