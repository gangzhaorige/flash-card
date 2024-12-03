import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flash_cards/repository/question_repository.dart';
import 'package:flash_cards/view_models/question_answer_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash_cards/api.dart';
import 'package:provider/provider.dart';
import '../locator.dart';

class PdfUploaderProvider extends ChangeNotifier {
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;
  bool _isUploading = false;

  Uint8List? get selectedFileBytes => _selectedFileBytes;
  String? get selectedFileName => _selectedFileName;
  bool get isUploading => _isUploading;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.bytes != null) {
      _selectedFileBytes = result.files.single.bytes;
      _selectedFileName = result.files.single.name;
      notifyListeners();
    }
  }

  Future<String> uploadFile(int topicId, Future<bool> Function(int, FormData) createQuestionFromPDF) async {
    if (_selectedFileBytes == null || _selectedFileName == null) {
      return 'Please select a file first.';
    }
    _isUploading = true;
    notifyListeners();
    try {
      final formData = FormData.fromMap({
        'pdfFile': MultipartFile.fromBytes(
          _selectedFileBytes!,
          filename: _selectedFileName!,
        ),
      });
      final response = await createQuestionFromPDF(topicId, formData);
      return response
          ? 'File uploaded successfully!'
          : 'Failed to upload file.';
    } catch (e) {
      return 'Error: $e';
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}