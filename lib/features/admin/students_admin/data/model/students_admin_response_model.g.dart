// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_admin_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentsAdminResponseModel _$StudentsAdminResponseModelFromJson(
  Map<String, dynamic> json,
) => StudentsAdminResponseModel(
  success: json['success'] as bool,
  status: (json['status'] as num).toInt(),
  message: json['message'] as String,
  data: StudentsAdminData.fromJson(json['data'] as Map<String, dynamic>),
  totalEnrollments: (json['total_enrollments'] as num?)?.toInt(),
);

Map<String, dynamic> _$StudentsAdminResponseModelToJson(
  StudentsAdminResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total_enrollments': instance.totalEnrollments,
};

StudentsAdminData _$StudentsAdminDataFromJson(Map<String, dynamic> json) =>
    StudentsAdminData(
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      totalStudents: (json['total_students'] as num?)?.toInt(),
      students: (json['students'] as List<dynamic>?)
          ?.map((e) => StudentsAdminModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalEnrollments: (json['total_enrollments'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StudentsAdminDataToJson(StudentsAdminData instance) =>
    <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'total_students': instance.totalStudents,
      'students': instance.students,
      'total_enrollments': instance.totalEnrollments,
    };
