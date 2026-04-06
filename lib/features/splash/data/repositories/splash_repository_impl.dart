import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import 'package:lms_admin_instructor/features/splash/data/model/auth_admin_check_auth_response_model.dart';
import 'package:lms_admin_instructor/features/splash/domain/splash_repository.dart';


class SplashRepositoryImpl implements SplashRepository {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  SplashRepositoryImpl({required this.apiConsumer, required this.cacheHelper});
  @override
  Future<Either<String, CheckAuthDataModel>> checkLogin() async {
    if (cacheHelper.getData(key: ApiKey.accessToken) == null ||
        cacheHelper.getData(key: ApiKey.accessToken) == "") {
      return const Left("No token found");
    }

    final result = await apiConsumer.get<CheckAuthResponseModel>(
      EndPoint.checkToken,
      fromJson: (json) => CheckAuthResponseModel.fromJson(json),
    );

    return await result.fold(
      (error) async {
        if (error.contains("Unauthorized") || error.contains("401")) {
          await _clearCache();
        }
        return Left(error);
      },
      (response) async {
        if (response.data != null) {
          return Right(response.data!);
        } else {
          return Left(response.message ?? "Unknown error");
        }
      },
    );
  }

  Future<void> _clearCache() async {
    await cacheHelper.removeData(key: ApiKey.accessToken);
    await cacheHelper.removeData(key: ApiKey.refreshToken);
    await cacheHelper.removeData(key: ApiKey.user);
    await cacheHelper.removeData(key: ApiKey.isLoggedIn);
  }
}

