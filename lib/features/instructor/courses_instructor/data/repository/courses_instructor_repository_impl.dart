import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/data/model/course_instructor_response_model.dart';
import 'package:lms_admin_instructor/features/instructor/courses_instructor/domain/repository/courses_instructor_repository.dart';

import 'package:lms_admin_instructor/core/utils/api_query_params.dart';

class CoursesInstructorRepositoryImpl implements CoursesInstructorRepository {
  final ApiConsumer apiConsumer;

  CoursesInstructorRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, CourseInstructorResponseModel>> getCoursesInstructor({
    required String instructorSlug,
    int? page,
    int? pageSize,
  }) async {
    return await apiConsumer.get<CourseInstructorResponseModel>(
      EndPoint.coursesInstructor(instructorSlug),
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
      ),
      fromJson: (json) => CourseInstructorResponseModel.fromJson(json),
    );
  }
}