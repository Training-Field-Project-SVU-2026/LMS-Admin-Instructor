import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/add_quiz_instructor/presentation/bloc/add_quiz_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/add_quiz_instructor/presentation/bloc/add_quiz_instructor_state.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/quiz_repository.dart';

class AddQuizInstructorBloc
    extends Bloc<AddQuizInstructorEvent, AddQuizInstructorState> {
  final QuizRepository quizRepository;

  AddQuizInstructorBloc({required this.quizRepository})
      : super(AddQuizInstructorInitial()) {
    on<CreateQuizEvent>(_onCreateQuiz);
    on<UpdateQuizEvent>(_onUpdateQuiz);
  }

  Future<void> _onCreateQuiz(
    CreateQuizEvent event,
    Emitter<AddQuizInstructorState> emit,
  ) async {
    emit(AddQuizInstructorLoading());
    final result = await quizRepository.createQuizForCourse(
      event.courseSlug,
      event.quizData,
    );
    result.fold(
      (error) => emit(AddQuizInstructorError(error)),
      (response) => emit(AddQuizInstructorSuccess(response)),
    );
  }

  Future<void> _onUpdateQuiz(
    UpdateQuizEvent event,
    Emitter<AddQuizInstructorState> emit,
  ) async {
    emit(AddQuizInstructorLoading());
    final result = await quizRepository.updateQuiz(
      event.courseSlug,
      event.quizSlug,
      event.quizData,
    );
    result.fold(
      (error) => emit(AddQuizInstructorError(error)),
      (response) => emit(AddQuizInstructorSuccess(response)),
    );
  }
}