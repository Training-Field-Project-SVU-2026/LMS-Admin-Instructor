import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/students_admin/domain/repository/students_admin_repository.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/bloc/student_admin_event.dart';
import 'package:lms_admin_instructor/features/students_admin/presentation/bloc/student_admin_state.dart';

class StudentAdminBloc extends Bloc<StudentAdminEvent, StudentAdminState> {
  final StudentsAdminRepository studentsAdminRepository;
  StudentAdminBloc({required this.studentsAdminRepository})
    : super(StudentAdminInitial()) {
    on<GetStudentsAdminEvent>(_onGetStudentsAdminEvent);
  }

  Future<void> _onGetStudentsAdminEvent(
    GetStudentsAdminEvent event,
    Emitter<StudentAdminState> emit,
  ) async {
    final currentState = state;
    final int pageToFetch = event.page ?? 1;

    if (pageToFetch == 1 || currentState is! StudentAdminLoaded) {
      emit(StudentAdminLoading());
    } else {
      if (currentState.studentAdminUIModel.currentPage >=
          currentState.studentAdminUIModel.totalPages) {
        return;
      }
      emit(currentState.copyWith(isPaginationLoading: true));
    }

    final result = await studentsAdminRepository.getStudentsAdmin(
      page: pageToFetch,
      pageSize: event.pageSize,
    );

    result.fold((failure) => emit(StudentAdminError(message: failure)), (
      responseModel,
    ) {
      final newEntity = responseModel.toEntity();

      if (pageToFetch == 1 || currentState is! StudentAdminLoaded) {
        emit(StudentAdminLoaded(studentAdminUIModel: newEntity));
      } else {
        final accumulatedStudents = [
          ...currentState.studentAdminUIModel.students,
          ...newEntity.students,
        ];
        emit(
          StudentAdminLoaded(
            studentAdminUIModel: newEntity.copyWith(
              students: accumulatedStudents,
            ),
            isPaginationLoading: false,
          ),
        );
      }
    });
  }
}
