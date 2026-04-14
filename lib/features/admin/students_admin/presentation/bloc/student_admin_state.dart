import 'package:lms_admin_instructor/features/admin/students_admin/domain/entity/student_admin_ui_model.dart';

class StudentAdminState {}

class StudentAdminInitial extends StudentAdminState {}

class StudentAdminLoading extends StudentAdminState {}

class StudentAdminLoaded extends StudentAdminState {
  final StudentAdminUIModel studentAdminUIModel;
  final bool isPaginationLoading;

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
