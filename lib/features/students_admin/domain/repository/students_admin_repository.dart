import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/students_admin/data/model/students_admin_response_model.dart';

abstract class StudentsAdminRepository {
  Future<Either<String, StudentsAdminResponseModel>> getAllStudentsAdmin({
    int? page,
    int? pageSize,
  });
}
