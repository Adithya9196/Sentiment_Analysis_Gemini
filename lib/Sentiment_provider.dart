import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SentimentProvider with ChangeNotifier{
  final model = GenerativeModel(
    model: dotenv.env['GEMINI_MODEL']!,
    apiKey: dotenv.env['GEMINI_API_KEY']!,
  );


  bool isLoading = false;
  String? status;


  Future<void> analyzeSentiment(String text) async{
    if(text.isEmpty) return;

    isLoading = true;
    notifyListeners();

    try{
      final prompt = '''
      Analyze the sentiment of the given text.
      Return only one word from this list:
      Positive, Negative, Neutral
      
      Text: "$text"
      ''';

      final response = await model.generateContent([Content.text(prompt)]);
      print(response);

      final result = response.text?.trim().toLowerCase();

      if(result == 'positive'){
        status = 'Positive';
      }else if(result == 'negative'){
        status = 'Negative';
      }else{
        status = 'Neutral';
      }

    }catch(e){
      debugPrint('Sentiment Error: $e');

    }
    isLoading = false;
    notifyListeners();
  }

}

