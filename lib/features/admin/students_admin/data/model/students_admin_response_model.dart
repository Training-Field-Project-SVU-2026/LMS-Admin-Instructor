import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/student_admin_ui_model.dart';
import 'students_admin_model.dart';

part 'students_admin_response_model.g.dart';

@JsonSerializable()
class StudentsAdminResponseModel {
  final bool success;
  final int status;
  final String message;
  final StudentsAdminData data;

  @JsonKey(name: 'total_enrollments')
  final int? totalEnrollments;

  StudentsAdminResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
    this.totalEnrollments,
  });

  factory StudentsAdminResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsAdminResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsAdminResponseModelToJson(this);

  StudentAdminUIModel toEntity() {
    return StudentAdminUIModel(
      students: data.students?.map((e) => e.toEntity()).toList() ?? [],
      totalEnrollments: data.totalEnrollments ?? 0,
      totalPages: data.totalPages ?? 1,
      currentPage: data.currentPage ?? 1,
    );
  }
}

@JsonSerializable()
class StudentsAdminData {
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_students')
  final int? totalStudents;
  final List<StudentsAdminModel>? students;

  @JsonKey(name: 'total_enrollments')
  final int? totalEnrollments;

  StudentsAdminData({
    this.totalPages,
    this.currentPage,
    this.totalStudents,
    this.students,
    this.totalEnrollments,
  });

  factory StudentsAdminData.fromJson(Map<String, dynamic> json) =>
      _$StudentsAdminDataFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsAdminDataToJson(this);
}
