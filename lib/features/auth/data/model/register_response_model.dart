
import 'package:lms_admin_instructor/core/common/user_model.dart';

class RegisterResponseModel {
  final String message;
  final UserModel? student;

  RegisterResponseModel({
    required this.message,
    this.student,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {

    return RegisterResponseModel(
      message: json['message'] ?? '',
      student: json['student'] != null ? UserModel.fromJson(json['student']) : null,
    );
  }

  
}
