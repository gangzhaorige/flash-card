import 'package:another_flushbar/flushbar.dart';
import 'package:flash_cards/commons/ui_helper.dart';
import 'package:flash_cards/view_models/topic_view_model.dart';
import 'package:flash_cards/views/questions/questions_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicCard extends StatelessWidget {
  final int id;
  final String subject;
  final String? description;
  final int numberOfCards;
  final DateTime createdAt;
  final Color backgroundColor; // New parameter for card color

  const TopicCard({super.key, 
    required this.id,
    required this.subject,
    this.description,
    required this.numberOfCards,
    required this.createdAt,
    this.backgroundColor = Colors.cyan,// Default color if not specified
  });

  void _showRemoveDeckDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Deck $subject'),
          content: const Text('Are you sure you want to remove this deck?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog without doing anything
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Provider.of<TopicViewModel>(context, listen: false).deleteTopic(id);
                Navigator.of(context).pop(); // Close the dialog
                await Flushbar(
                  flushbarPosition: FlushbarPosition.TOP,
                  title: 'Deck removed successfully!',
                  message: '$subject deck removed',
                  duration: const Duration(seconds: 1),
                ).show(context);
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _updateFormDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final subjectController = TextEditingController(text: subject);
    final descriptionController = TextEditingController(text: description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Subject and Description'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ],
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
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  // Call the ViewModel to create a new topic
                  Provider.of<TopicViewModel>(context, listen: false).updateTopic(id, subjectController.text, descriptionController.text);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _gotoCardsView(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) => Theme(
        data: Theme.of(context).copyWith(scaffoldBackgroundColor: const Color.fromARGB(255, 240, 244, 249)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 240, 244, 249),
            title: FittedBox(
              child: Text(
                'Topic: $subject',
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          body: QuestionsView(topicId: id),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            height: 320,
            width: 552,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onLongPress: () {
                  _updateFormDialog(context);
                },
                onTap: () {
                  _gotoCardsView(context);
                },
                borderRadius: BorderRadius.circular(15),
                splashColor: Colors.blue,
                splashFactory: InkRipple.splashFactory,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: backgroundColor.withOpacity(0.9), // Use the backgroundColor parameter
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subject,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            child: const Icon(
                              CupertinoIcons.xmark,
                              color: Colors.white,
                              size: 32,
                            ),
                            onTap:() {
                              _showRemoveDeckDialog(context);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10), // Spacing
                      // Number of Cards
                      Text(
                        '$numberOfCards cards',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(), // Push content to the bottom
                      // User Info Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 350,
                            child: Text(
                              description!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              softWrap: true, // Enables wrapping
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          Text(
                            '${createdAt.year} ${createdAt.month}/${createdAt.day}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 220,
            width: 220,
            child: Icon(
              Icons.bolt_sharp,
              size: 220,
              color: Colors.white.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}