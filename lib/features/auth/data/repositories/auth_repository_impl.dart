import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/auth/data/model/login_request_model.dart';
import 'package:lms_admin_instructor/features/auth/data/model/login_response_model.dart';
import 'package:lms_admin_instructor/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  AuthRepositoryImpl({required this.apiConsumer, required this.cacheHelper});

   @override
  Future<Either<String, LoginResponseModel>> login(
    LoginRequestModel request,
  ) async {
    final result = await apiConsumer.post<LoginResponseModel>(
      EndPoint.login,
      data: request.toJson(),
      fromJson: (json) => LoginResponseModel.fromJson(json),
    );

    return await result.fold(
      (error) => Left(error),
      (loginResponse) async {
        await cacheHelper.saveData(
          key: ApiKey.accessToken,
          value: loginResponse.accessToken,
        );
        await cacheHelper.saveData(
          key: ApiKey.refreshToken,
          value: loginResponse.refreshToken,
        );
        await cacheHelper.saveData(
          key: ApiKey.isLoggedIn,
          value: true,
        );

        final userJson = jsonEncode(loginResponse.user.toJson());
        await cacheHelper.saveData(key: ApiKey.user, value: userJson);

        await cacheHelper.saveData(
        key: ApiKey.slug,
        value: loginResponse.user.slug,
      );
        return Right(loginResponse);
      },
    );
  }

}
