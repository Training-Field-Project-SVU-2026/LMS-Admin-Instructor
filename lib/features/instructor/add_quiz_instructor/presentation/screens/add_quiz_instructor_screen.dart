import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/utils/get_responsive_size.dart';
import 'package:lms_admin_instructor/features/instructor/add_quiz_instructor/presentation/bloc/add_quiz_instructor_bloc.dart';
import 'package:lms_admin_instructor/features/instructor/add_quiz_instructor/presentation/bloc/add_quiz_instructor_event.dart';
import 'package:lms_admin_instructor/features/instructor/add_quiz_instructor/presentation/bloc/add_quiz_instructor_state.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/course_quiz_create_model.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'package:lms_admin_instructor/features/widgets/loading_indicator_widget.dart';
import 'widgets/question_item_widget.dart';

class AddQuizScreen extends StatefulWidget {
  final String slug;
  const AddQuizScreen({super.key, required this.slug});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quizNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<QuestionCreateModel> _questions = [];

  @override
  void initState() {
    super.initState();
    _addQuestion();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(
        QuestionCreateModel(
          questionName: '',
          mark: 1,
          questionType: 'single',
          choices: [
            ChoiceCreateModel(choiceName: '', isCorrect: true),
            ChoiceCreateModel(choiceName: '', isCorrect: false),
          ],
        ),
      );
    });
  }

  void _removeQuestion(int index) {
    setState(() {
      if (_questions.length > 1) {
        _questions.removeAt(index);
      }
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final quizData = CourseQuizCreateModel(
        quizName: _quizNameController.text,
        description: _descriptionController.text,
        questions: _questions,
        slug: widget.slug,
      );

      context.read<AddQuizInstructorBloc>().add(
        CreateQuizEvent(courseSlug: widget.slug, quizData: quizData),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('add_quiz'))),
      body: BlocConsumer<AddQuizInstructorBloc, AddQuizInstructorState>(
        listener: (context, state) {
          if (state is AddQuizInstructorSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.tr('quiz_created_success'))),
            );
            context.pop(true);
          } else if (state is AddQuizInstructorError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AddQuizInstructorLoading) {
            return const LoadingIndicatorWidget();
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.isDesktop ? 100.w : 16.w,
              vertical: 24.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr('quiz_info'),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    txt: context.tr('quiz_name'),
                    hint: context.tr('quiz_name'),
                    controller: _quizNameController,
                    validator: (value) => value == null || value.isEmpty
                        ? context.tr('required')
                        : null,
                  ),
                  SizedBox(height: 12.h),
                  CustomTextFormField(
                    txt: context.tr('description'),
                    hint: context.tr('description'),
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.tr('questions'),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _addQuestion,
                        icon: const Icon(Icons.add),
                        label: Text(context.tr('add_question')),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ..._questions.asMap().entries.map((entry) {
                    final index = entry.key;
                    return QuestionItemWidget(
                      index: index,
                      question: entry.value,
                      onRemove: () => _removeQuestion(index),
                      onUpdate: (updatedQuestion) {
                        setState(() {
                          _questions[index] = updatedQuestion;
                        });
                      },
                    );
                  }),
                  SizedBox(height: 32.h),
                  Center(
                    child: CustomPrimaryButton(
                      text: context.tr('submit'),
                      onTap: _submit,
                      width: context.isDesktop ? 300.w : double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
