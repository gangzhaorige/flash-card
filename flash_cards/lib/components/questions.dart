import 'package:flash_cards/components/question_answer_card.dart';
import 'package:flash_cards/view_models/question_answer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';

import '../model/question_answer_model.dart';

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<QuestionAnswerViewModel, bool>(
      selector: (_, viewModel) => viewModel.isLoadingQuestion,
      builder: (context, isLoading, child) {
        if (isLoading) {
          // Show a loading spinner while data is being fetched
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Selector<QuestionAnswerViewModel, List<CardModel>>(
          selector: (_, viewModel) => viewModel.questionAnswers,
          builder: (context, questionAnswers, child) {
            if (questionAnswers.isEmpty) {
              // Handle the case where there are no cards
              return const Center(
                child: Text('No questions available.'),
              );
            }
            return SizedBox(
              height: 450,
              child: CardSwiper(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                cardsCount: questionAnswers.length,
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                  return Center(
                    child: QuestionAnswerCard(
                      key: UniqueKey(),
                      card: questionAnswers[index],
                    ),
                  );
                },
                numberOfCardsDisplayed: 1,
                allowedSwipeDirection: const AllowedSwipeDirection.symmetric(horizontal: true),
                isLoop: true,
              ),
            );
          },
        );
      },
    );
  }
}