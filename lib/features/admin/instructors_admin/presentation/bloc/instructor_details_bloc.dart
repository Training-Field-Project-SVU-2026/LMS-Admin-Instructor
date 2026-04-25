import 'package:bloc/bloc.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/repository/instructor_admin_repoditory.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_event.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/presentation/bloc/instructor_details_state.dart';

class InstructorDetailsBloc
    extends Bloc<InstructorDetailsEvent, InstructorDetailsState> {
  final InstructorAdminRepository instructorAdminRepository;

  InstructorDetailsBloc({required this.instructorAdminRepository})
    : super(InstructorDetailsInitial()) {
    on<GetInstructorCoursesEvent>(_onGetInstructorCoursesEvent);
  }

  Future<void> _onGetInstructorCoursesEvent(
    GetInstructorCoursesEvent event,
    Emitter<InstructorDetailsState> emit,
  ) async {
    final currentState = state;
    final int pageToFetch = event.page!;

    if (pageToFetch == 1) {
      if (currentState is! InstructorCoursesLoaded) {
        emit(InstructorCoursesLoading());
      }
    } else {
      if (currentState is InstructorCoursesLoaded) {
        if (currentState.instructorCourseAdminUiModel.data!.currentPage >=
            currentState.instructorCourseAdminUiModel.data!.totalPages) {
          return;
        }
      } else {
        emit(InstructorCoursesLoading());
      }
    }

    final result = await instructorAdminRepository.getInstructorCoursesBySslug(
      pageToFetch,
      event.pageSize,
      event.slug,
    );
    result.fold(
      (failure) => emit(InstructorCoursesError(message: failure.toString())),
      (responseModel) {
        final newEntity = responseModel.toEntity();

        if (pageToFetch == 1 || currentState is! InstructorCoursesLoaded) {
          emit(
            InstructorCoursesLoaded(instructorCourseAdminUiModel: newEntity),
          );
        } else {
          final accumulatedInstructors = [
            ...currentState.instructorCourseAdminUiModel.data!.courses,
            ...newEntity.data!.courses,
          ];
          emit(
            InstructorCoursesLoaded(
              instructorCourseAdminUiModel: newEntity.copyWith(
                data: newEntity.data!.copyWith(courses: accumulatedInstructors),
              ),
            ),
          );
        }
      },
    );
  }
}
