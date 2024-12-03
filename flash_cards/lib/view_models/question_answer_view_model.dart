import 'dart:convert';

import 'package:flash_cards/repository/question_repository.dart';
import 'package:flash_cards/view_models/loading_view_model.dart';
import 'package:flutter/foundation.dart';

import '../model/question_answer_model.dart';
import 'topic_view_model.dart';

class QuestionAnswerViewModel extends LoadingViewModel {

  final QuestionAnswerRepository _questionAnswerRepository;

  QuestionAnswerViewModel(this._questionAnswerRepository);

  late TopicViewModel topicViewModel;

  List<CardModel> _questionAnswers = [];

  List<CardModel> get questionAnswers => _questionAnswers;

  AnswerExplanation explanation = AnswerExplanation(answer: [], explanation:'This AI is here to assist with detailed and accurate answers, leveraging advanced technology and extensive knowledge. While we strive for reliability, we recommend verifying critical details independently, especially for important decisions or complex topics. Your caution ensures the best use of this assistance.');

  bool isLoadingQuestion = false;

  void setTopicViewModel(TopicViewModel topicViewModel) {
    this.topicViewModel = topicViewModel;
  }

  Future<void> fetchQuestions(int topicId) async {
    if (isLoadingQuestion) return; // Prevent duplicate fetch calls
    isLoadingQuestion = true;
    notifyListeners();
    try {
      var response = await _questionAnswerRepository.fetchQuestionAnswers(topicId);
      List<CardModel> list = [];
      if(response?.statusCode == 200) {
        for(dynamic data in response?.data) {
          list.add(CardModel.fromJson(data));
        }
      } 
      _questionAnswers = list;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching questions: $error');
      }
    } finally {
      isLoadingQuestion = false;
      notifyListeners();
    }
  }

  Future<void> createQuestion(int topicId, dynamic data) async {
    if (isLoadingQuestion) return; // Prevent duplicate fetch calls
    isLoadingQuestion = true;
    notifyListeners();
    try {
      var response = await _questionAnswerRepository.createQuestionAnswer(topicId, data);
      if(response?.statusCode == 201) {
        CardModel newCard = CardModel.fromJson(response?.data);
        _questionAnswers.insert(0, newCard);
        topicViewModel.updateNumCards(topicId, 1);
        notifyListeners();
      } 
    } catch (error) {
      if (kDebugMode) {
        print('Error Creating questions: $error');
      }
    } finally {
      isLoadingQuestion = false;
      notifyListeners();
    }
  }

  Future<AnswerExplanation?> answerQuestion(CardModel questionCard) async {
    try {
      var choices = [];
      for(var choice in questionCard.choices) {
        choices.add({'choice_id': choice.choiceId, 'answer': choice.answer});
      }
      var data = {'question': questionCard.question, 'choices': choices};
      var response = await _questionAnswerRepository.explainQuestion(data);
      AnswerExplanation explanation = AnswerExplanation(answer: [], explanation: 'Error');
      if (response?.statusCode == 200) {
        explanation = AnswerExplanation.fromJson(jsonDecode(response?.data['response'])); 
      }
      return explanation;
    } catch (error) {
      if (kDebugMode) {
        print('Error Answering questions: $error');
      }
    }
    return null;
  }

  Future<bool> generateFromPDF(int topicId, dynamic data) async {
    try {
      var response = await _questionAnswerRepository.createQuestionFromPDF(topicId, data);
      List<CardModel> list = [];
      if(response?.statusCode == 200) {
        for(dynamic data in response?.data) {
          list.add(CardModel.fromJson(data));
        }
      } 
      _questionAnswers = [ ...list, ..._questionAnswers]; // Ensures a new reference
      topicViewModel.updateNumCards(topicId, list.length);
      notifyListeners();
      return true;
    } catch (error) {
      if (kDebugMode) {
        print('Error Creating questions: $error');
      }
    }
    return false;
  }

}