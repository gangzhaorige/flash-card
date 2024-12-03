import 'package:flutter/material.dart';

class CreateQuestionViewModel extends ChangeNotifier {
  String question = '';
  final List<TextEditingController> choiceControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<bool> correctChoices = [false, false];

  void setQuestion(String value) {
    question = value;
    notifyListeners();
  }

  void addChoice() {
    if (choiceControllers.length < 4) {
      choiceControllers.add(TextEditingController());
      correctChoices.add(false);
      notifyListeners();
    }
  }

  void removeChoice() {
    if (choiceControllers.length > 2) {
      choiceControllers.removeLast();
      correctChoices.removeLast();
      notifyListeners();
    }
  }

  void updateChoice(int index, String value, bool? isCorrect) {
    if (index >= 0 && index < choiceControllers.length) {
      choiceControllers[index].text = value;
      if (isCorrect != null) {
        correctChoices[index] = isCorrect;
      }
      notifyListeners();
    }
  }

  bool isChoiceLimitReached() => choiceControllers.length == 4;
  bool isChoiceLimitMinimum() => choiceControllers.length == 2;

  List<Map<String, dynamic>> getChoices() {
    return List.generate(choiceControllers.length, (index) {
      return {
        "choice_id": index + 1,
        "answer": choiceControllers[index].text.trim(),
        "is_correct": correctChoices[index],
      };
    });
  }

  Map<String, dynamic> toJson() {
    return {
      "question": question,
      "choices": getChoices(),
    };
  }

}