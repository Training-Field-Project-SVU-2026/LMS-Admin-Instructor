import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/auth/domain/repositories/auth_repository.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/form_controller_mixin.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with FormControllersMixin {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    if (!validateLoginForm()) {
      emit(AuthError(message: 'Please fill all fields correctly'));
      return;
    }

    emit(AuthLoading());

    final request = getLoginRequest();
    final result = await authRepository.login(request);

    result.fold(
      (errorMessage) {
        emit(AuthError(message: errorMessage));
      },
      (successResponse) {
        clearLoginControllers();
        emit(AuthSuccess(data: successResponse));
      },
    );
  }
}
