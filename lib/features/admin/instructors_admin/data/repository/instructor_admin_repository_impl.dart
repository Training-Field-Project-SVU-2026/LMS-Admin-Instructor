import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/core/utils/api_query_params.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_admin_respomse_model.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/domain/repository/instructor_admin_repoditory.dart';

class InstructorAdminRepositoryImpl implements InstructorAdminRepoditory {
  final ApiConsumer apiConsumer;
  InstructorAdminRepositoryImpl({required this.apiConsumer});
  @override
  Future<Either<String, InstructorAdminResponseModel>> getInstructorAdmin(
    int? page,
    int? pageSize,
  ) async {
    return await apiConsumer.get<InstructorAdminResponseModel>(
      EndPoint.instructorAdmin,
      queryParameters: ApiQueryParams.pagination(
        page: page,
        pageSize: pageSize,
      ),
      fromJson: (json) => InstructorAdminResponseModel.fromJson(json),
    );
  }
}
