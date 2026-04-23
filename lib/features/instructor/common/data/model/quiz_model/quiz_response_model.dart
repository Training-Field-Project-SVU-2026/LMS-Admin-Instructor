import 'package:json_annotation/json_annotation.dart';
import 'quiz_model.dart';

part 'quiz_response_model.g.dart';

@JsonSerializable()
class QuizResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final QuizData? data;

  QuizResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory QuizResponseModel.fromJson(Map<String, dynamic> json) => _$QuizResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizResponseModelToJson(this);
}

@JsonSerializable()
class QuizData {
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'total_quizzes')
  final int? totalQuizzes;
  final List<QuizModel>? quizzes;

  QuizData({
    this.totalPages,
    this.currentPage,
    this.totalQuizzes,
    this.quizzes,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) => _$QuizDataFromJson(json);
  Map<String, dynamic> toJson() => _$QuizDataToJson(this);
}
