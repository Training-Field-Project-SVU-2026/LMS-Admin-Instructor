import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';

class StudentAdminUIModel {
  final List<StudentItemUIModel> students;
  final int totalEnrollments;
  final int totalPages;
  final int currentPage;

  StudentAdminUIModel({
    required this.students,
    required this.totalEnrollments,
    required this.totalPages,
    required this.currentPage,
  });

  StudentAdminUIModel copyWith({
    List<StudentItemUIModel>? students,
    int? totalEnrollments,
    int? totalPages,
    int? currentPage,
  }) {
    return StudentAdminUIModel(
      students: students ?? this.students,
      totalEnrollments: totalEnrollments ?? this.totalEnrollments,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class StudentItemUIModel implements CustomDataTableRowModel {
  final String studentName;
  final String email;
  final bool isActive;
  final int enrollmentsCount;
  final String? image;

  StudentItemUIModel({
    required this.studentName,
    required this.email,
    required this.isActive,
    required this.enrollmentsCount,
    this.image,
  });

  @override
  List<String> get rowTexts => [
    studentName,
    email,
    isActive ? 'active' : 'inactive',
  ];

  @override
  String? get avatarUrl => image;

  @override
  VoidCallback? get onAction => null;

  @override
  VoidCallback? get onOptions => null;
}
