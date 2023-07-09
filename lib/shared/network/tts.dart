

import 'package:flutter/material.dart';
import 'package:graduation_project/shared/network/TextToSpeech.dart';

class TtsScreen extends StatelessWidget {
  const TtsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text To Speech"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textController,
          ),
          ElevatedButton(
              onPressed: (){
                TextToSpeech.speak(textController.text);
              } ,
              child: const Text("Speak"),
          ),
        ],
      ),
    );
  }
}
