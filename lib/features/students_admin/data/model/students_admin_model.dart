import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/student_admin_ui_model.dart';

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
  @JsonKey(name: 'is_verified')
  final bool isVerified;

  StudentsAdminModel({
    required this.studentName,
    required this.email,
    required this.isActive,
    required this.enrollmentsCount,
    this.image,
    required this.isVerified,
  });

  factory StudentsAdminModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsAdminModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsAdminModelToJson(this);

  StudentItemUIModel toEntity() {
    return StudentItemUIModel(
      studentName: studentName,
      email: email,
      isActive: isActive,
      enrollmentsCount: enrollmentsCount,
      image: image,
      isVerified: isVerified,
    );
  }
}
