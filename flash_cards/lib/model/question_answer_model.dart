// Model for Choice
class ChoiceModel {
  final int id;
  final int choiceId;
  final String answer;
  final bool isCorrect;

  ChoiceModel({
    required this.id,
    required this.choiceId,
    required this.answer,
    required this.isCorrect,
  });

  // Factory constructor to create a ChoiceModel from JSON
  factory ChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChoiceModel(
      id: json['id'],
      choiceId: json['choice_id'],
      answer: json['answer'],
      isCorrect: json['is_correct'],
    );
  }

  // Convert a ChoiceModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'choice_id': choiceId,
      'answer': answer,
      'is_correct': isCorrect,
    };
  }
}

// Model for Card
class CardModel {
  final int id;
  final String question;
  final List<ChoiceModel> choices;
  final String createdAt;
  final String updatedAt;

  CardModel({
    required this.id,
    required this.question,
    required this.choices,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a CardModel from JSON
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      question: json['question'],
      choices: (json['choices'] as List)
          .map((choiceJson) => ChoiceModel.fromJson(choiceJson))
          .toList(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Convert a CardModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'choices': choices.map((choice) => choice.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AnswerExplanation {
  final List<String> answer;
  final String explanation; 

  AnswerExplanation({
    required this.answer,
    required this.explanation,
  });

  // Factory constructor to create an object from JSON
  factory AnswerExplanation.fromJson(Map<String, dynamic> json) {
    return AnswerExplanation(
      answer: List<String>.from(json['answer']), // Convert the list from JSON
      explanation: json['explanation'],
    );
  }

  // Convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'explanation': explanation,
    };
  }
}