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
  final String slug;
  final String studentName;
  final String email;
  final bool isActive;
  final int enrollmentsCount;
  final String? image;
  final bool isVerified;
  final VoidCallback? onActionPressed;
  final VoidCallback? onOptionsPressed;

  StudentItemUIModel({
    required this.slug,
    required this.studentName,
    required this.email,
    required this.isActive,
    required this.enrollmentsCount,
    required this.isVerified,
    this.image,
    this.onActionPressed,
    this.onOptionsPressed,
  });

  StudentItemUIModel copyWith({
    String? slug,
    String? studentName,
    String? email,
    bool? isActive,
    int? enrollmentsCount,
    String? image,
    bool? isVerified,
    VoidCallback? onActionPressed,
    VoidCallback? onOptionsPressed,
  }) {
    return StudentItemUIModel(
      slug: slug ?? this.slug,
      studentName: studentName ?? this.studentName,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      enrollmentsCount: enrollmentsCount ?? this.enrollmentsCount,
      image: image ?? this.image,
      isVerified: isVerified ?? this.isVerified,
      onActionPressed: onActionPressed ?? this.onActionPressed,
      onOptionsPressed: onOptionsPressed ?? this.onOptionsPressed,
    );
  }

  @override
  List<String> get rowTexts => [
    studentName,
    email,
    isActive ? 'active' : 'inactive',
    isVerified ? 'verified' : 'not_verified',
  ];

  @override
  String? get avatarUrl => image;

  @override
  VoidCallback? get onAction => onActionPressed;

  @override
  VoidCallback? get onOptions => onOptionsPressed;
}
