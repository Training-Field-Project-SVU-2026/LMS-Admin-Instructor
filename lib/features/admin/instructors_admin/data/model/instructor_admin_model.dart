import 'package:json_annotation/json_annotation.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/entity/instructor_admin_ui_model.dart';

part 'instructor_admin_model.g.dart';

@JsonSerializable()
class InstructorAdminModel {
  @JsonKey(name: 'first_name')
  final String? first_name;
  @JsonKey(name: 'last_name')
  final String? last_name;
  final String? email;
  final String? slug;
  final String? bio;
  final String? description;
  final String? image;

  InstructorAdminModel({
    this.slug,
    this.first_name,
    this.last_name,
    this.email,
    this.bio,
    this.description,
    this.image,
  });

  factory InstructorAdminModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorAdminModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstructorAdminModelToJson(this);

  InstructoritemUiModel toEntity() {
    return InstructoritemUiModel(
      slug: slug ?? "",
      first_name: first_name ?? "",
      last_name: last_name ?? "",
      email: email ?? "",
      bio: bio ?? "",
      description: description ?? "",
      image: image ?? "",
    );
  }
}
