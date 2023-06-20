
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../shared/network/styles/colors.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {

   SpeechToText speechToText = SpeechToText();

  String text = "Hold the button and start speaking";
  bool isListening = false;
  @override
  // void initState(){
  //
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: AvatarGlow(
        endRadius: 90.0,
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        glowColor: lighten(Colors.pink, .2),
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 2000),
        showTwoGlows: true ,
        child: GestureDetector(
          onTapDown: (details) async{
              if(!isListening)
              {
                bool av = await speechToText.initialize();
                if(av){
                  setState(() {
                    isListening = true;
                  });
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },
                  );
                }

              }
          },
          onTapUp:(details){
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            radius: 35,
            backgroundColor: lighten(Colors.pink, .2),
            child: Icon(isListening ? Icons.mic : Icons.mic_none, color: Colors.white),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: lighten(Colors.pink, .2),
        centerTitle: true,
        leading: Icon(Icons.sort_rounded,color: Colors.white),
        title: Text(
          ' Speech to Text'
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 150.0),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Text(text,
          style: const TextStyle(
            color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w600,)
          ),
          ),
      ),
      );
  }
}
