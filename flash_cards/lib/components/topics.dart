import 'dart:math';

import 'package:flash_cards/components/topic_card.dart';
import 'package:flash_cards/model/question_answer_model.dart';
import 'package:flash_cards/model/topic.dart';
import 'package:flash_cards/view_models/topic_view_model.dart';
import 'package:flash_cards/views/landing/landing_mobile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Topics extends StatelessWidget {
  const Topics({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      tablet: (BuildContext context) => 
      Consumer<TopicViewModel>(
        builder: (context, viewModel, child) {
          final topics = viewModel.topics; // Access topics directly
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 16 / 9, // Adjust for height/width ratio
            ),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              return TopicCard(
                id: topics[index].id,
                subject: topics[index].subject,
                description: topics[index].description!,
                numberOfCards: topics[index].numCards,
                backgroundColor: colors[Random().nextInt(4)],
                createdAt: topics[index].createdAt,
              );
            },
          );
        },
      ),
      desktop: (BuildContext context) => 
      Consumer<TopicViewModel>(
        builder: (context, viewModel, child) {
          final topics = viewModel.topics; // Access topics directly
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 16 / 9, // Adjust for height/width ratio
            ),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              return TopicCard(
                id: topics[index].id,
                subject: topics[index].subject,
                description: topics[index].description!,
                numberOfCards: topics[index].numCards,
                backgroundColor: colors[Random().nextInt(4)],
                createdAt: topics[index].createdAt,
              );
            },
          );
        },
      ),
      mobile: (BuildContext context) => SingleChildScrollView(
        child: Consumer<TopicViewModel>(
          builder:(context, viewModel, child) {
            return Column(
              children: [
                const SizedBox(height: 10),
                for(var topic in viewModel.topics) ...[
                  TopicCard(
                    id: topic.id,
                    subject: topic.subject,
                    description: topic.description!,
                    numberOfCards: topic.numCards,
                    backgroundColor: colors[Random().nextInt(4)],
                    createdAt: topic.createdAt,
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
