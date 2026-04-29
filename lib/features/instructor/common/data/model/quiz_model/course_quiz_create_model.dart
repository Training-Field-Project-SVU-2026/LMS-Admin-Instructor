import 'package:json_annotation/json_annotation.dart';

part 'course_quiz_create_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CourseQuizCreateModel {
  final String? slug;
  @JsonKey(name: 'quiz_name')
  final String? quizName;
  final String? description;
  @JsonKey(name: "max_attempts")
  final int? maxAttempts;
  final List<QuestionCreateModel>? questions;

  CourseQuizCreateModel({
    this.slug,
    this.quizName,
    this.description,
    this.maxAttempts,
    this.questions,
  });

  factory CourseQuizCreateModel.fromJson(Map<String, dynamic> json) =>
      _$CourseQuizCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseQuizCreateModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class QuestionCreateModel {
  @JsonKey(name: 'question_name')
  final String? questionName;
  final int? mark;
  @JsonKey(name: 'question_type')
  final String? questionType;
  final List<ChoiceCreateModel>? choices;

  QuestionCreateModel({
    this.questionName,
    this.mark,
    this.questionType,
    this.choices,
  });

  factory QuestionCreateModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionCreateModelToJson(this);
}

@JsonSerializable()
class ChoiceCreateModel {
  @JsonKey(name: 'choice_name')
  final String? choiceName;
  @JsonKey(name: 'isCorrect')
  final bool? isCorrect;

  ChoiceCreateModel({
    this.choiceName,
    this.isCorrect,
  });

  factory ChoiceCreateModel.fromJson(Map<String, dynamic> json) =>
      _$ChoiceCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoiceCreateModelToJson(this);
}
