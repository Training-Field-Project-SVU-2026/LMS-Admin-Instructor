import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/entity/course_instructor_ui_model.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/repository/courses_instructor_repository.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/presentation/bloc/courses_instructor_state.dart';

class CoursesInstructorBloc
    extends Bloc<CoursesInstructorEvent, CoursesInstructorState> {
  final CoursesInstructorRepository repository;

  CoursesInstructorBloc({required this.repository})
      : super(CoursesInstructorInitial()) {
    on<GetCoursesInstructorEvent>(_onGetCourses);
  }

  Future<void> _onGetCourses(
    GetCoursesInstructorEvent event,
    Emitter<CoursesInstructorState> emit,
  ) async {
    if (state is CoursesInstructorLoaded && (event.page ?? 1) > 1) {
      emit(
        (state as CoursesInstructorLoaded).copyWith(isPaginationLoading: true),
      );
    } else {
      emit(CoursesInstructorLoading());
    }

    final response = await repository.getCoursesInstructor(
      instructorSlug: event.instructorSlug,
      page: event.page,
      pageSize: event.pageSize,
    );

    response.fold(
      (error) => emit(CoursesInstructorError(message: error)),
      (responseModel) {
        final courseList = responseModel.toEntity();

        if (state is CoursesInstructorLoaded && (event.page ?? 1) > 1) {
          final currentCourses = (state as CoursesInstructorLoaded).courseListUIModel.courses;
          emit(
            CoursesInstructorLoaded(
              courseListUIModel: courseList.copyWith(
                courses: [...currentCourses, ...courseList.courses],
              ),
            ),
          );
        } else {
          emit(CoursesInstructorLoaded(courseListUIModel: courseList));
        }
      },
    );
  }
}
