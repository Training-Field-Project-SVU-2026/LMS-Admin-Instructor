import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/add_instructor_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/entity/instructor_admin_ui_model.dart';

class InstructorAdminState {}

class InstructorAdminInitial extends InstructorAdminState {}

class InstructorAdminLoading extends InstructorAdminState {}

class InstructorAdminLoaded extends InstructorAdminState {
  final InstructorAdminUiModel instructorAdminUiModel;
  final bool isPaginationLoading;
  InstructorAdminLoaded({
    required this.instructorAdminUiModel,
    this.isPaginationLoading = false,
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

class AddInstructorLoading extends InstructorAdminState {}

class AddInstructorSuccess extends InstructorAdminState {
  final AddInstructorModel addInstructorModel;
  AddInstructorSuccess({required this.addInstructorModel});
}

class AddInstructorError extends InstructorAdminState {
  final String message;
  AddInstructorError({required this.message});
}
