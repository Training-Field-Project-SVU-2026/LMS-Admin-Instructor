part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}
