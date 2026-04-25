import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/data/models/update_course_request_model.dart';
import 'package:lms_admin_instructor/features/instructor/course_details/domain/entity/course_details_ui_model.dart';

mixin EditCourseControllerMixin {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController categoryController;
  
  String? selectedLevel;
  bool isActive = true;

  void initControllers(CourseDetailsUIModel course) {
    nameController = TextEditingController(text: course.title);
    descriptionController = TextEditingController(text: course.description);
    priceController = TextEditingController(text: course.price);
    categoryController = TextEditingController(text: course.category);
    selectedLevel = course.level.toLowerCase();
    isActive = course.isActive;
  }

  UpdateCourseRequestModel getUpdateRequest() {
    return UpdateCourseRequestModel(
      title: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: priceController.text.trim(),
      category: categoryController.text.trim(),
      level: selectedLevel!,
      isActive: isActive,
    );
  }

  void disposeEditControllers() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
  }
}
