import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/video_repository.dart';
import 'course_video_event.dart';
import 'course_video_state.dart';

class CourseVideoBloc extends Bloc<CourseVideoEvent, CourseVideoState> {
  final VideoRepository videoRepository;

  CourseVideoBloc({required this.videoRepository})
    : super(CourseVideoInitial()) {
    on<GetCourseVideosEvent>((event, emit) async {
      print('CourseVideoBloc: Fetching videos for slug -> ${event.courseSlug}');
      emit(CourseVideoLoading());

      final result = await videoRepository.getCourseVideos(event.courseSlug);

      result.fold(
        (error) {
          print('CourseVideoBloc: API Error -> $error');
          emit(CourseVideoError(message: error));
        },
        (response) {
          print(
            'CourseVideoBloc: API Success -> ${response.data.length} videos found',
          );
          emit(CourseVideoLoaded(videos: response.data));
        },
      );
    });
  }
}
