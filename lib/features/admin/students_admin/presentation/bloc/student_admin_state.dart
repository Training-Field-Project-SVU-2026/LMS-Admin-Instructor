import 'package:lms_admin_instructor/core/common/mixins/paginated_state.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/domain/entity/student_admin_ui_model.dart';

class StudentAdminState {}

class StudentAdminInitial extends StudentAdminState {}

class StudentAdminLoading extends StudentAdminState {}

class StudentAdminLoaded extends StudentAdminState implements PaginatedState<StudentItemUIModel, StudentAdminUIModel> {
  final StudentAdminUIModel studentAdminUIModel;
  @override
  final bool isPaginationLoading;

  @override
  StudentAdminUIModel? get uiModel => studentAdminUIModel;

  StudentAdminLoaded({
    required this.studentAdminUIModel,
    this.isPaginationLoading = false,
  });

  StudentAdminLoaded copyWith({
    StudentAdminUIModel? studentAdminUIModel,
    bool? isPaginationLoading,
  }) {
    return StudentAdminLoaded(
      studentAdminUIModel: studentAdminUIModel ?? this.studentAdminUIModel,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}

class StudentAdminError extends StudentAdminState {
  final String message;
  StudentAdminError({required this.message});
}