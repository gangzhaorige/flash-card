

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flash_cards/views/questions/questions_mobile.dart';
import 'package:flutter/material.dart';

import '../../commons/responsive.dart';

class QuestionsView extends StatelessWidget {
  const QuestionsView({super.key, required this.topicId});

  final int topicId;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: QuestionMobileView(topicId : topicId),
    );
  }
}