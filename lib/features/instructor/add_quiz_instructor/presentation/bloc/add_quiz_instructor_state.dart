import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/quiz_detail_model.dart';

abstract class AddQuizInstructorState {}

class AddQuizInstructorInitial extends AddQuizInstructorState {}

class AddQuizInstructorLoading extends AddQuizInstructorState {}

class AddQuizInstructorSuccess extends AddQuizInstructorState {
  final QuizDetailResponseModel quizResponse;
  AddQuizInstructorSuccess(this.quizResponse);
}

class AddQuizInstructorError extends AddQuizInstructorState {
  final String message;
  AddQuizInstructorError(this.message);
}