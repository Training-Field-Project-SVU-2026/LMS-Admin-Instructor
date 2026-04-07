// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsAdminModel _$StudentsAdminFromJson(Map<String, dynamic> json) =>
    StudentsAdminModel(
      studentName: json['student_name'] as String,
      email: json['email'] as String,
      isActive: json['is_active'] as bool,
      enrollmentsCount: (json['enrollments_count'] as num).toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$StudentsAdminToJson(StudentsAdminModel instance) =>
    <String, dynamic>{
      'student_name': instance.studentName,
      'email': instance.email,
      'is_active': instance.isActive,
      'enrollments_count': instance.enrollmentsCount,
      'image': instance.image,
    };
