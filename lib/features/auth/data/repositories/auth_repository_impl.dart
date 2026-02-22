import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConsumer apiConsumer;

  AuthRepositoryImpl({required this.apiConsumer});

  @override
  Future<void> login(String email, String password) async {
    // Implementation using apiConsumer
  }

  @override
  Future<void> register(String name, String email, String password) async {
    // Implementation using apiConsumer
  }
}
