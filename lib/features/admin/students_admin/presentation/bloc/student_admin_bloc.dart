import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/domain/repository/students_admin_repository.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/presentation/bloc/student_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/presentation/bloc/student_admin_state.dart';

class StudentAdminBloc extends Bloc<StudentAdminEvent, StudentAdminState> {
  final StudentsAdminRepository studentsAdminRepository;
  StudentAdminBloc({required this.studentsAdminRepository})
    : super(StudentAdminInitial()) {
    on<GetStudentsAdminEvent>(_onGetStudentsAdminEvent);
    on<DeleteStudentAdminEvent>(_onDeleteStudentAdminEvent);
  }

  Future<void> _onDeleteStudentAdminEvent(
    DeleteStudentAdminEvent event,
    Emitter<StudentAdminState> emit,
  ) async {
    final currentState = state;
    if (currentState is StudentAdminLoaded) {
      final result = await studentsAdminRepository.deleteStudent(event.slug);

      result.fold(
        (failure) {
          // TODO
          // You might want to emit an error state or show a toast
          // For now we just stay in the current state
        },
        (unit) {
          final updatedStudents = currentState.studentAdminUIModel.students
              .where((student) => student.slug != event.slug)
              .toList();

          emit(
            currentState.copyWith(
              studentAdminUIModel: currentState.studentAdminUIModel.copyWith(
                students: updatedStudents,
                totalEnrollments:
                    currentState.studentAdminUIModel.totalEnrollments - 1,
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> _onGetStudentsAdminEvent(
    GetStudentsAdminEvent event,
    Emitter<StudentAdminState> emit,
  ) async {
    final currentState = state;
    final int pageToFetch = event.page ?? 1;

    if (pageToFetch == 1) {
      if (currentState is! StudentAdminLoaded) {
        emit(StudentAdminLoading());
      }
    } else {
      if (currentState is StudentAdminLoaded) {
        if (currentState.studentAdminUIModel.currentPage >=
            currentState.studentAdminUIModel.totalPages) {
          return;
        }
        emit(currentState.copyWith(isPaginationLoading: true));
      } else {
        emit(StudentAdminLoading());
      }
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
