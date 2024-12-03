
import 'package:flash_cards/components/topics.dart';
import 'package:flash_cards/locator.dart';
import 'package:flash_cards/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../view_models/topic_view_model.dart'; // Import your provider

const List<Color> colors = [Color.fromARGB(255, 37, 150, 190), Color.fromARGB(255, 27, 153, 139), Color.fromARGB(255, 123, 97, 255), Color.fromARGB(255, 255,184, 101)];


class LandingMobile extends StatelessWidget {
  const LandingMobile({super.key});

  void _showFormDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? subject;
    String? description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Subject and Description'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Subject'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    subject = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value;
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
                  Provider.of<TopicViewModel>(context, listen: false).createNewTopic(subject!, description!);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),  
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Flash Cards",
                      style: TextStyle(
                        fontSize: 30.0, // Font size for title
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Selector<TopicViewModel, int>(
                      selector: (context, viewModel) => viewModel.getNumberOfDecks(),
                      builder: (context, count, child) {
                        return Text(
                          "$count Deck${count > 2 ? 's' : ''}",
                          style: const TextStyle(
                            fontSize: 14.0, // Font size for subtitle
                            color: Colors.blue,
                            height: 2.0, //
                          ),
                        );
                      },
                    ),
                  ],
                ),
                // Right Section: Bell Icon with "ON" label
                Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.yellow, // Background color for bell icon
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: Provider.of<TopicViewModel>(context, listen: false).fetchTopics,
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 1.5),
                    const Text(
                      "ON",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: SingleChildScrollView(child: Topics()),
          )
        ),
        SizedBox(
          height: 70,
          // color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: const Icon(
                  CupertinoIcons.add_circled,
                  size: 40,
                  color: Colors.blue,
                ),
                onTap:() {
                  _showFormDialog(context);
                },
              ),
              GestureDetector(
                child: const Icon(
                  CupertinoIcons.profile_circled,
                  size: 40,
                  color: Colors.blue,
                ),
                onTap:() async {
                  var res = await locator<AuthenticationService>().logout();
                  if(res.statusCode == 204) {
                    Get.toNamed('/login');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
