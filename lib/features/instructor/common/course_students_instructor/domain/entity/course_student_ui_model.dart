class CourseStudentUIModel {
  final String name;
  final String email;
  final String avatar;
  final String enrollmentDate;
  final double progress; // 0.0 to 1.0
  final String slug;

  CourseStudentUIModel({
    required this.name,
    required this.email,
    required this.avatar,
    required this.enrollmentDate,
    required this.progress,
    required this.slug,
  });
}
