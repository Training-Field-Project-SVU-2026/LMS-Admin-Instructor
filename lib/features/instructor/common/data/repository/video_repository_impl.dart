import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import '../../domain/repository/video_repository.dart';
import '../model/video_model/course_video_model.dart';

class VideoRepositoryImpl implements VideoRepository {
  final ApiConsumer apiConsumer;

  VideoRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseVideoResponseModel>> getCourseVideos(
    String courseSlug,
  ) async {
    return await apiConsumer.get<CourseVideoResponseModel>(
      EndPoint.courseVideos(courseSlug),
      fromJson: (json) => CourseVideoResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, CourseVideoModel>> addVideo(
    String courseSlug,
    Map<String, dynamic> data,
  ) async {
    return await apiConsumer.post<CourseVideoModel>(
      EndPoint.createVideo,
      data: data,
      isFromData: data.containsKey('video_upload'),
      fromJson: (json) => CourseVideoModel.fromJson(json),
    );
  }
}
