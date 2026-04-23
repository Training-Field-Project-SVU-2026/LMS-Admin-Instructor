import 'package:json_annotation/json_annotation.dart';

part 'quiz_model.g.dart';

@JsonSerializable()
class QuizModel {
  @JsonKey(name: 'quiz_name')
  final String? quizName;
  final String? slug;
  @JsonKey(name: 'total_mark')
  final num? totalMark;
  @JsonKey(name: 'max_attempts')
  final num? maxAttempts;
  @JsonKey(name: 'course_name')
  final String? courseName;
  @JsonKey(name: 'attempts_used')
  final String? attemptsUsed;
  @JsonKey(name: 'best_score')
  final String? bestScore;
  @JsonKey(name: 'quiz_status')
  final String? quizStatus;
  final String? description;

  QuizModel({
    this.quizName,
    this.slug,
    this.totalMark,
    this.maxAttempts,
    this.courseName,
    this.attemptsUsed,
    this.bestScore,
    this.quizStatus,
    this.description,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => _$QuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizModelToJson(this);
}
