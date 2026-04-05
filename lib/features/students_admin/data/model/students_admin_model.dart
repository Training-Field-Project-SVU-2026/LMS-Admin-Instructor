import 'package:json_annotation/json_annotation.dart';

part 'students_admin_model.g.dart';

@JsonSerializable()
class StudentsAdminModel {
  @JsonKey(name: 'student_name')
  final String studentName;
  final String email;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'enrollments_count')
  final int enrollmentsCount;
  final String? image;

  StudentsAdminModel({
    required this.studentName,
    required this.email,
    required this.isActive,
    required this.enrollmentsCount,
    this.image,
  });

  factory StudentsAdminModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsAdminFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsAdminToJson(this);
}
