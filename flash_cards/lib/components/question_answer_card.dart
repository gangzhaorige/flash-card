import 'package:flash_cards/model/question_answer_model.dart';
import 'package:flash_cards/view_models/question_answer_view_model.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionAnswerCard extends StatelessWidget {
  const QuestionAnswerCard({
    super.key,
    required this.card,
  });

  void showInformationDialog(BuildContext context,
      {required String title, required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  final CardModel card;
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 500,
          width: 420,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      card.question,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      for(int i = 0; i < 4; i++)...[
                        i < card.choices.length ? _buildOptionButton(card.choices[i].answer, card.choices[i].choiceId, false) : _buildOptionButton('-----------', i + 1, false),
                        const SizedBox(height: 7),
                      ]
                    ],
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.data_exploration,
                      size: 50,
                      color: Colors.blue,
                    ),
                    onTap: () async {
                      var res = await Provider.of<QuestionAnswerViewModel>(context, listen: false).answerQuestion(card);
                      showInformationDialog(context, title: 'AI Response', message: res!.explanation);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      back: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 420,
          height: 500,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      card.question,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      for(int i = 0; i < 4; i++)...[
                        i < card.choices.length ? _buildOptionButton(card.choices[i].answer, card.choices[i].choiceId, card.choices[i].isCorrect) : _buildOptionButton('-----------', i + 1, false),
                        const SizedBox(height: 7),
                      ]
                    ],
                  ),
                  GestureDetector(
                    child: const Icon(
                      Icons.data_exploration,
                      size: 50,
                    ),
                    onTap: () {
                      Provider.of<QuestionAnswerViewModel>(context, listen: false).answerQuestion(card);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, int index, bool isCorrect) {
    return SizedBox(
      height: 40,
      width: 330,
      child: ElevatedButton(
        onPressed: () {
          // Add your logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:const Color.fromARGB(255, 240, 244, 249),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          elevation: 3.0, // Adds a shadow to the button
        ),
        child: Row(
          children: [
            // Circle container for the image or icon
            Container(
              height: 35.0,
              width: 35.0,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                color: !isCorrect ? Colors.blue.withOpacity(0.7) : Colors.red.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: Text(
                '$index',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            const SizedBox(width: 12.0), // Spacing between image and text
            // Text for the button
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}