
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ContentProvider with ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  String? _result="";
  String? get result => _result;

  bool isLoading = false;

  // Available models
  final String models = 'gemini-1.5-flash';


  Future<void> generateContent() async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      _result = 'No API_KEY environment variable';
      notifyListeners();
      return;
    }

    final model = GenerativeModel(model: models, apiKey: apiKey);
    final content = [Content.text(controller.text)];

    try {
      isLoading = true;
      notifyListeners();

      final response = await model.generateContent(content);
      _result = response.text;
    } catch (e) {
      _result = 'Error: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearResult() {
    _result = "";
    controller.text="";
    notifyListeners();
  }
}