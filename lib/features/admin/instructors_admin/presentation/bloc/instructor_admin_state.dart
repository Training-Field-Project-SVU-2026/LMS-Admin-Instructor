import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/entity/instructor_admin_ui_model.dart';

class InstructorAdminState {}

class InstructorAdminInitial extends InstructorAdminState {}

class InstructorAdminLoading extends InstructorAdminState {}

class InstructorAdminLoaded extends InstructorAdminState {
  final InstructorAdminUiModel instructorAdminUiModel;
  final bool? isPaginationLoading;
  InstructorAdminLoaded({
    required this.instructorAdminUiModel,
    this.isPaginationLoading,
  });

  InstructorAdminLoaded copyWith({
    final InstructorAdminUiModel? instructorAdminUiModel,
    final bool? isPaginationLoading,
  }) {
    return InstructorAdminLoaded(
      instructorAdminUiModel:
          instructorAdminUiModel ?? this.instructorAdminUiModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class InstructorAdminError extends InstructorAdminState {
  final String message;
  InstructorAdminError({required this.message});
}
