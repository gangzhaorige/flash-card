import 'package:flash_cards/view_models/question_answer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_question_view_model.dart';

class CreateQuestionView extends StatelessWidget {
  const CreateQuestionView({super.key, required this.topicId});

  final int topicId;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateQuestionViewModel(),
      child: Consumer<CreateQuestionViewModel>(
        builder: (context, formViewModel, child) {
          return AlertDialog(
            title: const Text('Create a Question'),
            content: Form(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Question Input Field
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Question'),
                      onChanged: (value) => formViewModel.setQuestion(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a question';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    // Dynamic Choices Input Fields
                    for (int i = 0; i < formViewModel.choiceControllers.length; i++) ...[
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              controller: formViewModel.choiceControllers[i],
                              decoration: InputDecoration(labelText: 'Choice ${i + 1}'),
                              onChanged: (value) => formViewModel.updateChoice(
                                i,
                                value,
                                formViewModel.correctChoices[i],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  formViewModel.updateChoice(
                                    i,
                                    formViewModel.choiceControllers[i].text,
                                    !formViewModel.correctChoices[i],
                                  );
                                },
                                child: Checkbox(
                                  value: formViewModel.correctChoices[i],
                                  onChanged: (value) {
                                    if (value != null) {
                                      formViewModel.updateChoice(
                                        i,
                                        formViewModel.choiceControllers[i].text,
                                        value,
                                      );
                                    }
                                  },
                                  splashRadius: 0,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                    // Add/Remove Buttons
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: !formViewModel.isChoiceLimitReached()
                                ? formViewModel.addChoice
                                : null,
                            icon: const Icon(Icons.add),
                            label: const Text(
                              'Add Choice',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: !formViewModel.isChoiceLimitMinimum()
                                ? formViewModel.removeChoice
                                : null,
                            icon: const Icon(Icons.remove),
                            label: const Text(
                              'Remove Choice',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formViewModel.question.isEmpty ||
                      formViewModel.choiceControllers.any((c) => c.text.isEmpty)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all fields before submitting.'),
                      ),
                    );
                  } else {
                    var data = formViewModel.toJson();
                    Provider.of<QuestionAnswerViewModel>(context, listen: false).createQuestion(topicId, data);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
  }
}