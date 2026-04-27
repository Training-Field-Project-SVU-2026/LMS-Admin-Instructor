import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/course_student_ui_model.dart';

part 'course_students_response_model.g.dart';

@JsonSerializable()
class CourseStudentsResponseModel {
  final int count;
  final String? next;
  final String? previous;
  final List<CourseStudentModel> results;

  CourseStudentsResponseModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory CourseStudentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseStudentsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStudentsResponseModelToJson(this);

  CourseStudentsListUIModel toEntity({required int currentPage, int pageSize = 10}) {
    return CourseStudentsListUIModel(
      students: results.map((e) => e.toEntity()).toList(),
      totalStudents: count,
      totalPages: (count / pageSize).ceil(),
      currentPage: currentPage,
    );
  }
}

@JsonSerializable()
class CourseStudentModel {
  @JsonKey(name: 'student_slug')
  final String? studentSlug;
  @JsonKey(name: 'student_name')
  final String? studentName;
  @JsonKey(name: 'student_email')
  final String? studentEmail;
  @JsonKey(name: 'enrollment_date')
  final String? enrollmentDate;
  final String? progress;

  CourseStudentModel({
    this.studentSlug,
    this.studentName,
    this.studentEmail,
    this.enrollmentDate,
    this.progress,
  });

  factory CourseStudentModel.fromJson(Map<String, dynamic> json) =>
      _$CourseStudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseStudentModelToJson(this);

  CourseStudentItemUIModel toEntity() {
    return CourseStudentItemUIModel(
      name: studentName ?? '',
      email: studentEmail ?? '',
      avatar: "",
      enrollmentDate: enrollmentDate ?? '',
      progress: (double.tryParse(progress?.replaceAll('%', '') ?? '0') ?? 0.0) / 100.0,
      slug: studentSlug ?? '',
    );
  }
}
