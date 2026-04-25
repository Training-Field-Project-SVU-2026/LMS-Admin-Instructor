import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/course_details_response_model.dart';

abstract class CourseDetailsRepository {
  Future<Either<String,CourseDetailsResponseModel>> getCourseDetails(String slug);
}
