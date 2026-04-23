import 'package:dartz/dartz.dart';
import 'package:lms_admin_instructor/core/services/remote/api_consumer.dart';
import 'package:lms_admin_instructor/core/services/remote/endpoints.dart';
import '../../domain/repository/quiz_repository.dart';
import '../model/quiz_model/quiz_response_model.dart';
import '../model/quiz_model/quiz_detail_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final ApiConsumer apiConsumer;

  QuizRepositoryImpl({required this.apiConsumer});

  @override
  Future<Either<String, QuizResponseModel>> getQuizzes(String courseSlug) async {
    return await apiConsumer.get<QuizResponseModel>(
      EndPoint.courseQuizzes(courseSlug),
      fromJson: (json) => QuizResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, QuizDetailResponseModel>> getQuizDetails(String quizSlug) async {
    return await apiConsumer.get<QuizDetailResponseModel>(
      EndPoint.quizDetails(quizSlug),
      fromJson: (json) => QuizDetailResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, QuizDetailResponseModel>> createQuiz(String courseSlug, Map<String, dynamic> data) async {
    return await apiConsumer.post<QuizDetailResponseModel>(
      EndPoint.courseQuizzes(courseSlug),
      data: data,
      fromJson: (json) => QuizDetailResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, QuizDetailResponseModel>> updateQuiz(String courseSlug, String quizSlug, Map<String, dynamic> data) async {
    return await apiConsumer.patch<QuizDetailResponseModel>(
      EndPoint.courseQuizzes(courseSlug),
      data: {
        ...data,
        'slug': quizSlug,
      },
      fromJson: (json) => QuizDetailResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, Unit>> deleteQuiz(String courseSlug, String quizSlug) async {
    return await apiConsumer.delete<Unit>(
      EndPoint.courseQuizzes(courseSlug),
      data: {'slug': quizSlug},
      fromJson: (json) => unit,
    );
  }

  //? Questions
  @override
  Future<Either<String, List<QuestionModel>>> getQuizQuestions(String quizSlug) async {
    return await apiConsumer.getRaw<List<QuestionModel>>(
      EndPoint.quizQuestions(quizSlug),
      fromJson: (json) => (json as List).map((e) => QuestionModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<Either<String, QuestionModel>> createQuestion(String quizSlug, Map<String, dynamic> data) async {
    return await apiConsumer.post<QuestionModel>(
      EndPoint.createQuestion(quizSlug),
      data: data,
      fromJson: (json) => QuestionModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, QuestionModel>> updateQuestion(String quizSlug, String questionSlug, Map<String, dynamic> data) async {
    return await apiConsumer.patch<QuestionModel>(
      EndPoint.updateQuestion(quizSlug, questionSlug),
      data: data,
      fromJson: (json) => QuestionModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, Unit>> deleteQuestion(String quizSlug, String questionSlug) async {
    return await apiConsumer.delete<Unit>(
      EndPoint.deleteQuestion(quizSlug, questionSlug),
      fromJson: (json) => unit,
    );
  }

  //? Choices
  @override
  Future<Either<String, List<ChoiceModel>>> getQuestionChoices(String quizSlug, String questionSlug) async {
    return await apiConsumer.getRaw<List<ChoiceModel>>(
      EndPoint.questionChoices(quizSlug, questionSlug),
      fromJson: (json) => (json as List).map((e) => ChoiceModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<Either<String, ChoiceModel>> createChoice(String quizSlug, String questionSlug, Map<String, dynamic> data) async {
    return await apiConsumer.post<ChoiceModel>(
      EndPoint.createChoice(quizSlug, questionSlug),
      data: data,
      fromJson: (json) => ChoiceModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, ChoiceModel>> updateChoice(String quizSlug, String questionSlug, String choiceSlug, Map<String, dynamic> data) async {
    return await apiConsumer.patch<ChoiceModel>(
      EndPoint.updateChoice(quizSlug, questionSlug, choiceSlug),
      data: data,
      fromJson: (json) => ChoiceModel.fromJson(json),
    );
  }

  @override
  Future<Either<String, Unit>> deleteChoice(String quizSlug, String questionSlug, String choiceSlug) async {
    return await apiConsumer.delete<Unit>(
      EndPoint.deleteChoice(quizSlug, questionSlug, choiceSlug),
      fromJson: (json) => unit,
    );
  }
}