import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/admin/instructors_admin/data/model/instructor_admin_respomse_model.dart';

abstract class InstructorAdminRepoditory {
  Future<Either<String, InstructorAdminResponseModel>> getInstructorAdmin(
    int? page,
    int? pageSize,
  );
}
