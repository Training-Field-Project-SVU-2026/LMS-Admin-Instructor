import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/common/domain/repository/quiz_repository.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_event.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/presentation/bloc/course_quiz_bloc/course_quiz_state.dart';

class CourseQuizBloc extends Bloc<CourseQuizEvent, CourseQuizState> {
  final QuizRepository quizRepository;
  CourseQuizBloc({required this.quizRepository}) : super(CourseQuizInitial()){
    
  }

}