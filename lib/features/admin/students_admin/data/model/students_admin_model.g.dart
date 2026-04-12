// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsAdminModel _$StudentsAdminModelFromJson(Map<String, dynamic> json) =>
    StudentsAdminModel(
      slug: json['slug'] as String?,
      studentName: json['student_name'] as String?,
      email: json['email'] as String?,
      isActive: json['is_active'] as bool?,
      enrollmentsCount: (json['enrollments_count'] as num?)?.toInt(),
      image: json['image'] as String?,
      isVerified: json['is_verified'] as bool?,
    );

Map<String, dynamic> _$StudentsAdminModelToJson(StudentsAdminModel instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'student_name': instance.studentName,
      'email': instance.email,
      'is_active': instance.isActive,
      'enrollments_count': instance.enrollmentsCount,
      'image': instance.image,
      'is_verified': instance.isVerified,
    };
