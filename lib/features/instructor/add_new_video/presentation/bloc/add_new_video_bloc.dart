import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/domain/repository/video_repository.dart';
import 'add_new_video_event.dart';
import 'add_new_video_state.dart';
import 'package:dio/dio.dart';

class AddNewVideoBloc extends Bloc<AddNewVideoEvent, AddNewVideoState> {
  final VideoRepository videoRepository;

  AddNewVideoBloc({required this.videoRepository})
    : super(AddNewVideoInitial()) {
    on<AddVideoEvent>((event, emit) async {
      emit(AddNewVideoLoading());

      final Map<String, dynamic> data = {
        'title': event.title,
        'course': event.course,
        'duration': event.duration,
      };

      if (event.videoUrl != null && event.videoUrl!.isNotEmpty) {
        data['video_url'] = event.videoUrl;
      } else if (event.videoUpload != null) {
        if (event.videoUpload is String) {
          final String filePath = event.videoUpload;
          final String fileName = filePath.split('/').last;
          data['video_upload'] = await MultipartFile.fromFile(
            filePath,
            filename: fileName,
          );
        } else {
          data['video_upload'] = event.videoUpload;
        }
      }

      final result = await videoRepository.addVideo(event.courseSlug, data);

      result.fold(
        (error) => emit(AddNewVideoError(message: error)),
        (video) => emit(AddNewVideoSuccess(video: video)),
      );
    });
  }
}
