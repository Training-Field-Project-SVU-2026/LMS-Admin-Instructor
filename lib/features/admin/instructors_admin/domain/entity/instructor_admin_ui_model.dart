import 'dart:ui';

import 'package:lms_admin_instructor/features/widgets/custom_data_table/custom_data_table_model.dart';

class InstructorAdminUiModel {
  final List<InstructoritemUiModel> instructors;
  final int totalInstructors;
  final int totalPages;
  final int currentPage;

  InstructorAdminUiModel({
    required this.instructors,
    required this.totalInstructors,
    required this.totalPages,
    required this.currentPage,
  });

  InstructorAdminUiModel copyWith({
    List<InstructoritemUiModel>? instructors,
    int? totalInstructors,
    int? totalPages,
    int? currentPage,
  }) {
    return InstructorAdminUiModel(
      instructors: instructors ?? this.instructors,
      totalInstructors: totalInstructors ?? this.totalInstructors,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class InstructoritemUiModel implements CustomDataTableRowModel {
  final String first_name;
  final String last_name;
  final String email;
  final String slug;
  final String bio;
  final String description;
  final String? image;
  final VoidCallback? onActionPressed;
  final VoidCallback? onOptionsPressed;

  InstructoritemUiModel({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.slug,
    required this.bio,
    required this.description,
    this.image,
    this.onActionPressed,
    this.onOptionsPressed,
  });

  InstructoritemUiModel copyWith({
    String? first_name,
    String? last_name,
    String? email,
    String? slug,
    String? bio,
    String? description,
    String? image,
    VoidCallback? onActionPressed,
    VoidCallback? onOptionsPressed,
  }) {
    return InstructoritemUiModel(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      slug: slug ?? this.slug,
      bio: bio ?? this.bio,
      description: description ?? this.description,
      image: image ?? this.image,
      onActionPressed: onActionPressed ?? this.onActionPressed,
      onOptionsPressed: onOptionsPressed ?? this.onOptionsPressed,
    );
  }

  @override
  String? get avatarUrl => image;

  @override
  // TODO: implement onAction
  VoidCallback? get onAction => throw UnimplementedError();

  @override
  // TODO: implement onOptions
  VoidCallback? get onOptions => throw UnimplementedError();

  @override
  List<String> get rowTexts => [first_name, last_name, email, bio, description];
}
