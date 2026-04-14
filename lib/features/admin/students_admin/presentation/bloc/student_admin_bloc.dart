import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/mixins/paginated_list_mixin.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/domain/entity/student_admin_ui_model.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/domain/repository/students_admin_repository.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/presentation/bloc/student_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/students_admin/presentation/bloc/student_admin_state.dart';

class StudentAdminBloc extends Bloc<StudentAdminEvent, StudentAdminState>
    with
        PaginatedListMixin<
            StudentAdminEvent,
            StudentAdminState,
            StudentItemUIModel,
            StudentAdminUIModel,
            StudentAdminLoaded,
            StudentAdminError,
            StudentAdminLoading> {
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
          // TODO: Unified Error/Toast handling
        },
        (unit) {
          final updatedStudents =
              currentState.studentAdminUIModel.students
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
    final int pageToFetch = event.page ?? 1;

    if (!shouldHandlePagination(pageToFetch, state)) return;

    if (pageToFetch == 1) {
      if (state is! StudentAdminLoaded) {
        emit(StudentAdminLoading());
      }
    } else {
      emit((state as StudentAdminLoaded).copyWith(isPaginationLoading: true));
    }

    final result = await studentsAdminRepository.getStudentsAdmin(
      page: pageToFetch,
      pageSize: event.pageSize,
    );

    result.fold(
      (failure) => emit(StudentAdminError(message: failure)),
      (responseModel) {
        handlePaginatedResponse(
          page: pageToFetch,
          newEntity: responseModel.toEntity(),
          currentState: state,
          emit: emit.call,
          loadedStateBuilder: (model, isPaging) =>
              StudentAdminLoaded(studentAdminUIModel: model, isPaginationLoading: isPaging),
          errorStateBuilder: (msg) => StudentAdminError(message: msg),
          loadingStateBuilder: () => StudentAdminLoading(),
        );
      },
    );
  }
}
