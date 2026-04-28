import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/course_quiz_create_model.dart';

abstract class AddQuizInstructorEvent {}

class CreateQuizEvent extends AddQuizInstructorEvent {
  final String courseSlug;
  final CourseQuizCreateModel quizData;

  CreateQuizEvent({required this.courseSlug, required this.quizData});
}

class UpdateQuizEvent extends AddQuizInstructorEvent {
  final String courseSlug;
  final String quizSlug;
  final CourseQuizCreateModel quizData;

  UpdateQuizEvent({
    required this.courseSlug,
    required this.quizSlug,
    required this.quizData,
  });
}