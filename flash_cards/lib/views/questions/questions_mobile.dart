import 'package:flash_cards/components/question/create_question_view.dart';
import 'package:flash_cards/view_models/question_answer_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/questions.dart';
import '../../view_models/pdfuploader.dart';

class QuestionMobileView extends StatefulWidget {
  const QuestionMobileView({super.key, required this.topicId});

  final int topicId;

  @override
  State<QuestionMobileView> createState() => _QuestionMobileViewState();
}

class _QuestionMobileViewState extends State<QuestionMobileView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<QuestionAnswerViewModel>(context, listen: false).fetchQuestions(widget.topicId);
    });
    super.initState();
  }

  void _createQuestionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateQuestionView(topicId: widget.topicId);
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          flex: 1,
          child: Questions()
        ),
        SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: const Icon(
                  Icons.picture_as_pdf,
                  size: 40,
                  color: Colors.blue,
                ),
                onTap:() {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) {
                      return ChangeNotifierProvider(
                        create: (_) => PdfUploaderProvider(),
                        child: PdfUploaderBottomSheet(topicId: widget.topicId),
                      );
                    },
                  );
                },
              ),
              GestureDetector(
                child: const Icon(
                  CupertinoIcons.add_circled,
                  size: 40,
                  color: Colors.blue,
                ),
                onTap:() {
                  _createQuestionDialog(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PdfUploaderBottomSheet extends StatelessWidget {
  const PdfUploaderBottomSheet({super.key, required this.topicId});

  final int topicId;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PdfUploaderProvider>(context);

    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Text(
              'Upload PDF',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: provider.pickFile,
              child: const Text('Select PDF'),
            ),
            const SizedBox(height: 20),
            provider.selectedFileName != null
                ? Text('Selected file: ${provider.selectedFileName}')
                : const Text('No file selected'),
            const SizedBox(height: 20),
            provider.isUploading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      final message = await provider.uploadFile(topicId, Provider.of<QuestionAnswerViewModel>(context, listen: false).generateFromPDF);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Upload PDF'),
                  ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}