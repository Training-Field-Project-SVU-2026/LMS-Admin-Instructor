import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/repositories/course_details_repository.dart';

import 'course_details_event.dart';
import 'course_details_state.dart';

class CourseDetailsBloc extends Bloc<CourseDetailsEvent, CourseDetailsState> {
  final CourseDetailsRepository repository;

  CourseDetailsBloc({required this.repository}) : super(CourseDetailsInitial()) {
    on<GetCourseDetailsEvent>(_onGetCourseDetailsEvent);
  }

  Future<void> _onGetCourseDetailsEvent(
    GetCourseDetailsEvent event,
    Emitter<CourseDetailsState> emit,
  ) async {
    emit(CourseDetailsLoading());

    final failureOrCourseDetails = await repository.getCourseDetails(event.slug);

    failureOrCourseDetails.fold(
      (failure) => emit(CourseDetailsError(message: failure)),
      (success) {
        if (success.data != null) {
          emit(CourseDetailsLoaded(courseDetails: success.data!.toEntity()));
        } else {
          emit(CourseDetailsError(message: success.message ?? 'Unknown error occurred'));
        }
      },
    );
  }
}
