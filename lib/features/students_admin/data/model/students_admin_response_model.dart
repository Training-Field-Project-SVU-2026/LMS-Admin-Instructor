import 'package:json_annotation/json_annotation.dart';
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
}

@JsonSerializable()
class StudentsAdminData {
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'current_page')
  final int currentPage;
  @JsonKey(name: 'total_students')
  final int totalStudents;
  final List<StudentsAdminModel> students;

  @JsonKey(name: 'total_enrollments')
  final int totalEnrollments;

  StudentsAdminData({
    required this.totalPages,
    required this.currentPage,
    required this.totalStudents,
    required this.students,
    required this.totalEnrollments,
  });

  factory StudentsAdminData.fromJson(Map<String, dynamic> json) =>
      _$StudentsAdminDataFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsAdminDataToJson(this);
}
