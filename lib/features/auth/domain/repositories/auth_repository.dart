
import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/features/auth/data/model/login_request_model.dart';
import 'package:lms_admin_instructor/features/auth/data/model/login_response_model.dart';

abstract class AuthRepository {
  Future<Either<String, LoginResponseModel>> login(LoginRequestModel request);
}
