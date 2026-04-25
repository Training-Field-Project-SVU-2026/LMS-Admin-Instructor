import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/course_details_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/repositories/course_details_repository.dart';

class CourseDetailsRepositoryImpl implements CourseDetailsRepository {
  final ApiConsumer apiConsumer;

  CourseDetailsRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseDetailsResponseModel>> getCourseDetails(
    String slug,
  ) async {
    return await apiConsumer.get<CourseDetailsResponseModel>(
      EndPoint.courseDetails(slug),
      fromJson: (json) => CourseDetailsResponseModel.fromJson(json),
    );
  }
}