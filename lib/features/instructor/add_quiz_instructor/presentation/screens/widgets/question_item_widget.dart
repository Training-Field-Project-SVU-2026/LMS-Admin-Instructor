import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/instructor/common/data/model/quiz_model/course_quiz_create_model.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';
import 'choice_item_widget.dart';

class QuestionItemWidget extends StatefulWidget {
  final int index;
  final QuestionCreateModel question;
  final VoidCallback onRemove;
  final Function(QuestionCreateModel) onUpdate;

  const QuestionItemWidget({
    super.key,
    required this.index,
    required this.question,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  State<QuestionItemWidget> createState() => _QuestionItemWidgetState();
}

class _QuestionItemWidgetState extends State<QuestionItemWidget> {
  late TextEditingController _nameController;
  late TextEditingController _markController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.question.questionName);
    _markController = TextEditingController(text: widget.question.mark?.toString() ?? '1');
    
    _nameController.addListener(_updateQuestion);
    _markController.addListener(_updateQuestion);
  }

  void _updateQuestion() {
    widget.onUpdate(QuestionCreateModel(
      questionName: _nameController.text,
      mark: int.tryParse(_markController.text) ?? 1,
      questionType: widget.question.questionType,
      choices: widget.question.choices,
    ));
  }

  @override
  void didUpdateWidget(QuestionItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question.questionName != widget.question.questionName &&
        _nameController.text != widget.question.questionName) {
      _nameController.text = widget.question.questionName ?? '';
    }
    if (oldWidget.question.mark != widget.question.mark &&
        _markController.text != widget.question.mark?.toString()) {
      _markController.text = widget.question.mark?.toString() ?? '1';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 24.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: context.colorScheme.outline.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14.r,
                  backgroundColor: context.colorScheme.primary,
                  child: Text(
                    '${widget.index + 1}',
                    style: TextStyle(color: context.colorScheme.onPrimary, fontSize: 12.sp),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    context.tr('question_details'),
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: widget.onRemove,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              txt: context.tr('question_name'),
              hint: context.tr('question_name'),
              controller: _nameController,
              validator: (value) =>
                  value == null || value.isEmpty ? context.tr('required') : null,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    txt: context.tr('mark'),
                    hint: context.tr('mark'),
                    controller: _markController,
                    validator: (value) =>
                        value == null || value.isEmpty ? context.tr('required') : null,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: widget.question.questionType,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(value: 'single', child: Text(context.tr('single_choice'))),
                      DropdownMenuItem(value: 'multiple', child: Text(context.tr('multiple_choice'))),
                    ],
                    onChanged: (val) {
                      widget.onUpdate(QuestionCreateModel(
                        questionName: widget.question.questionName,
                        mark: widget.question.mark,
                        questionType: val,
                        choices: widget.question.choices,
                      ));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.tr('choices'),
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    final updatedChoices = List<ChoiceCreateModel>.from(widget.question.choices ?? []);
                    updatedChoices.add(ChoiceCreateModel(choiceName: '', isCorrect: false));
                    widget.onUpdate(QuestionCreateModel(
                      questionName: widget.question.questionName,
                      mark: widget.question.mark,
                      questionType: widget.question.questionType,
                      choices: updatedChoices,
                    ));
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(context.tr('add_choice'), style: TextStyle(fontSize: 12.sp)),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            ...widget.question.choices?.asMap().entries.map((entry) {
              final choiceIndex = entry.key;
              return ChoiceItemWidget(
                index: choiceIndex,
                choice: entry.value,
                onRemove: () {
                  final updatedChoices = List<ChoiceCreateModel>.from(widget.question.choices ?? []);
                  if (updatedChoices.length > 2) {
                    updatedChoices.removeAt(choiceIndex);
                    widget.onUpdate(QuestionCreateModel(
                      questionName: widget.question.questionName,
                      mark: widget.question.mark,
                      questionType: widget.question.questionType,
                      choices: updatedChoices,
                    ));
                  }
                },
                onUpdate: (updatedChoice) {
                  final updatedChoices = List<ChoiceCreateModel>.from(widget.question.choices ?? []);
                  
                  if (widget.question.questionType == 'single' && updatedChoice.isCorrect == true) {
                    for (var i = 0; i < updatedChoices.length; i++) {
                      updatedChoices[i] = ChoiceCreateModel(
                        choiceName: updatedChoices[i].choiceName,
                        isCorrect: i == choiceIndex,
                      );
                    }
                  } else {
                    updatedChoices[choiceIndex] = updatedChoice;
                  }

                  widget.onUpdate(QuestionCreateModel(
                    questionName: widget.question.questionName,
                    mark: widget.question.mark,
                    questionType: widget.question.questionType,
                    choices: updatedChoices,
                  ));
                },
              );
            }) ?? [],
          ],
        ),
      ),
    );
  }
}
