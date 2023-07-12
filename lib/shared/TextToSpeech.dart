import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech
{
  static FlutterTts tts = FlutterTts();
  static iniTts() async{
    // print(await tts.getLanguages);
    tts.setLanguage("en-US");
    tts.setPitch(1.0);
    // tts.setSpeechRate(0.2);
  }
  static speak(String text) async{

    tts.setStartHandler(() {
      print("TTS IS STARTED");
    });

    tts.setCompletionHandler(() {
      print("TTS IS COMPLETED");
    });

    tts.setErrorHandler((message) {
      print(message);
    });

    await tts.awaitSpeakCompletion(true);
    tts.speak(text);
  }
}