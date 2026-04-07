part of 'instructor_admin_bloc.dart';

sealed class InstructorAdminState extends Equatable {
  const InstructorAdminState();
  
  @override
  List<Object> get props => [];
}

final class InstructorAdminInitial extends InstructorAdminState {}
