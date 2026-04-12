import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/student_admin_ui_model.dart';

part 'students_admin_model.g.dart';

@JsonSerializable()
class StudentsAdminModel {
  final String? slug;
  @JsonKey(name: 'student_name')
  final String? studentName;
  final String? email;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'enrollments_count')
  final int? enrollmentsCount;
  final String? image;
  @JsonKey(name: 'is_verified')
  final bool? isVerified;

  StudentsAdminModel({
    this.slug,
    this.studentName,
    this.email,
    this.isActive,
    this.enrollmentsCount,
    this.image,
    this.isVerified,
  });

  factory StudentsAdminModel.fromJson(Map<String, dynamic> json) =>
      _$StudentsAdminModelFromJson(json);
  Map<String, dynamic> toJson() => _$StudentsAdminModelToJson(this);

  StudentItemUIModel toEntity() {
    return StudentItemUIModel(
      slug: slug ?? '',
      studentName: studentName ?? 'N/A',
      email: email ?? '',
      isActive: isActive ?? false,
      enrollmentsCount: enrollmentsCount ?? 0,
      image: image,
      isVerified: isVerified ?? false,
    );
  }
}
