import 'package:bloc/bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/repository/instructor_admin_repoditory.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_admin_state.dart';

class InstructorAdminBloc
    extends Bloc<GetInstructorAdminEvent, InstructorAdminState> {
  final InstructorAdminRepoditory instructorAdminRepoditory;

  InstructorAdminBloc({required this.instructorAdminRepoditory})
      : super(InstructorAdminInitial()) {
    on<GetInstructorAdminEvent>(_onGetInstructorAdminEvent);
  }

  Future<void> _onGetInstructorAdminEvent(
    GetInstructorAdminEvent event,
    Emitter<InstructorAdminState> emit,
  ) async {
    final currentState = state;
    final int pageToFetch = event.page ?? 1;

    if (pageToFetch == 1) {
      if (currentState is! InstructorAdminLoaded) {
        emit(InstructorAdminLoading());
      }
    } else {
      if (currentState is InstructorAdminLoaded) {
        if (currentState.instructorAdminUiModel.currentPage >=
            currentState.instructorAdminUiModel.totalPages) {
          return;
        }
        emit(currentState.copyWith(isPaginationLoading: true));
      } else {
        emit(InstructorAdminLoading());
      }
    }

    final result = await instructorAdminRepoditory.getInstructorAdmin(
      pageToFetch,
      event.pageSize,
    );

    result.fold(
      (failure) => emit(InstructorAdminError(message: failure)),
      (responseModel) {
        final newEntity = responseModel.toEntity();

        if (pageToFetch == 1 || currentState is! InstructorAdminLoaded) {
          emit(InstructorAdminLoaded(instructorAdminUiModel: newEntity));
        } else {
          final accumulatedInstructors = [
            ...currentState.instructorAdminUiModel.instructors,
            ...newEntity.instructors,
          ];
          emit(
            InstructorAdminLoaded(
              instructorAdminUiModel: newEntity.copyWith(
                instructors: accumulatedInstructors,
              ),
              isPaginationLoading: false,
            ),
          );
        }
      },
    );
  }
}
