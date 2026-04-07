import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'instructor_admin_event.dart';
part 'instructor_admin_state.dart';

class InstructorAdminBloc extends Bloc<InstructorAdminEvent, InstructorAdminState> {
  InstructorAdminBloc() : super(InstructorAdminInitial()) {
    on<InstructorAdminEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
