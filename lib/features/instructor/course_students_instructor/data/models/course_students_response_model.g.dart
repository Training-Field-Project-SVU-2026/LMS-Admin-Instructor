// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_students_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseStudentsResponseModel _$CourseStudentsResponseModelFromJson(
  Map<String, dynamic> json,
) => CourseStudentsResponseModel(
  count: (json['count'] as num).toInt(),
  next: json['next'] as String?,
  previous: json['previous'] as String?,
  results: (json['results'] as List<dynamic>)
      .map((e) => CourseStudentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CourseStudentsResponseModelToJson(
  CourseStudentsResponseModel instance,
) => <String, dynamic>{
  'count': instance.count,
  'next': instance.next,
  'previous': instance.previous,
  'results': instance.results,
};

CourseStudentModel _$CourseStudentModelFromJson(Map<String, dynamic> json) =>
    CourseStudentModel(
      studentSlug: json['student_slug'] as String?,
      studentName: json['student_name'] as String?,
      studentEmail: json['student_email'] as String?,
      enrollmentDate: json['enrollment_date'] as String?,
      progress: json['progress'] as String?,
    );

Map<String, dynamic> _$CourseStudentModelToJson(CourseStudentModel instance) =>
    <String, dynamic>{
      'student_slug': instance.studentSlug,
      'student_name': instance.studentName,
      'student_email': instance.studentEmail,
      'enrollment_date': instance.enrollmentDate,
      'progress': instance.progress,
    };
